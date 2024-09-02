import * as functions from "firebase-functions";
import { DocumentReference } from "firebase-admin/firestore";
import { Question } from "@models/Question";
import { Quiz } from "@models/Quiz";
import { QuizResult } from "@models/QuizResult";
import { QuizStartTime } from "@models/QuizStartTime";
import { parseQuestionListRef, fetchTitle } from "../utils/firestoreHelpers";
import { db } from "../index";

export const createQuiz = functions.https.onCall(async (data, context) => {
    const { questionIdList, type, talkId, sponsorId, quizTitle } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    try {
        const userDoc = await db.collection("users").doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError("not-found", "User not found.", {
                errorCode: "user-not-found",
            });
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError(
                "not-found",
                "User data not found.",
                { errorCode: "user-not-found" }
            );
        }

        if (userData.role != "staff") {
            throw new functions.https.HttpsError(
                "permission-denied",
                "User not authorized.",
                { errorCode: "permission-denied" }
            );
        }

        const quizRef = db.collection("quizzes");

        const questionListRef: DocumentReference[] = (
            questionIdList as string[]
        ).map((docId: string) => db.collection("questions").doc(docId));

        const questionList = await parseQuestionListRef(questionListRef, false);

        let maxScore = 0;
        questionList.forEach((question) => {
            maxScore += question.value ?? 0;
        });

        const quizDoc = await quizRef.add({
            questionList: questionListRef,
            type: type,
            talkId: talkId ?? "",
            sponsorId: sponsorId ?? "",
            quizTitle: quizTitle ?? "",
            maxScore: maxScore,
            isOpen: false,
            timerDuration: 1000 * 60 * 3, // 3 minutes. We can change this value dynamically for each quiz if we want
        });

        return JSON.stringify({ quizId: quizDoc.id });
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while creating the quiz.",
            error
        );
    }
});

export const getQuiz = functions.https.onCall(async (data, context) => {
    const { quizId } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    const uid = context.auth.uid;

    if (!quizId) {
        throw new functions.https.HttpsError(
            "invalid-argument",
            "The function must be called with a valid quizId.",
            { errorCode: "invalid-argument" }
        );
    }

    try {
        const quizDoc = await db.collection("quizzes").doc(quizId).get();

        if (!quizDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Quiz not found.", {
                errorCode: "quiz-not-found",
            });
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            throw new functions.https.HttpsError(
                "failed-precondition",
                "Quiz is not open.",
                { errorCode: "quiz-not-open" }
            );
        }

        const questionList: Question[] = await parseQuestionListRef(
            quizData.questionList,
            true
        );

        const quiz: Quiz = {
            quizId: quizDoc.id,
            quizTitle: quizData.title,
            type: quizData.type,
            talkId: quizData.talkId,
            sponsorId: quizData.sponsorId,
            maxScore: quizData.maxScore,
            isOpen: null,
            questionList: questionList,
            timerDuration: quizData.timerDuration,
        };

        const startTimeDoc = db
            .collection("users")
            .doc(uid)
            .collection("quizStartTimes")
            .doc(quizId);
        const startTimeDocSnapshot = await startTimeDoc.get();

        if (!startTimeDocSnapshot.exists) {
            const startTime: QuizStartTime = { startTimestamp: Date.now() };
            await startTimeDoc.set(startTime);
        } else {
            const startTimeData = startTimeDocSnapshot.data();

            if (!startTimeData) {
                throw new functions.https.HttpsError(
                    "not-found",
                    "Quiz start time for user not found.",
                    { errorCode: "quiz-start-time-not-found" }
                );
            }

            quiz.timerDuration -= Date.now() - startTimeData.startTimestamp;

            if (quiz.timerDuration <= 0) {
                throw new functions.https.HttpsError(
                    "failed-precondition",
                    "Quiz time is up.",
                    { errorCode: "quiz-time-up" }
                );
            }
        }

        return JSON.stringify(quiz);
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while fetching the quiz.",
            error
        );
    }
});

export const submitQuiz = functions.https.onCall(async (data, context) => {
    const { quizId, answerList } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    const uid = context.auth.uid;

    if (!quizId || !Array.isArray(answerList)) {
        throw new functions.https.HttpsError(
            "invalid-argument",
            "The function must be called with a valid quizId and answerList.",
            { errorCode: "invalid-argument" }
        );
    }

    try {
        const quizDoc = await db.collection("quizzes").doc(quizId).get();

        if (!quizDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Quiz not found.", {
                errorCode: "quiz-not-found",
            });
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            throw new functions.https.HttpsError(
                "failed-precondition",
                "Quiz is not open.",
                { errorCode: "quiz-not-open" }
            );
        }

        const answerDoc = await db
            .collection("users")
            .doc(uid)
            .collection("quizResults")
            .doc(quizId)
            .get();

        if (answerDoc.exists) {
            throw new functions.https.HttpsError(
                "already-exists",
                "Quiz already submitted.",
                { errorCode: "quiz-already-submitted" }
            );
        }

        let score = 0;
        const maxScore = quizData.maxScore;

        if (answerList.length !== quizData.questionList.length) {
            throw new functions.https.HttpsError(
                "invalid-argument",
                "The answerList must have the same length as the questionList.",
                { errorCode: "invalid-argument" }
            );
        }

        const questionList: Question[] = await parseQuestionListRef(
            quizData.questionList,
            false
        );

        questionList.forEach((question: Question, index: number) => {
            if (question.correctAnswer === answerList[index]) {
                score += question.value || 0;
            }
        });

        const startTimeDoc = await db
            .collection("users")
            .doc(uid)
            .collection("quizStartTimes")
            .doc(quizId)
            .get();

        if (!startTimeDoc.exists) {
            throw new functions.https.HttpsError(
                "not-found",
                "Quiz start time for user not found.",
                { errorCode: "quiz-start-time-not-found" }
            );
        }

        const startTimeData = startTimeDoc.data();

        if (!startTimeData) {
            throw new functions.https.HttpsError(
                "not-found",
                "Quiz start time for user not found.",
                { errorCode: "quiz-start-time-not-found" }
            );
        }

        if (
            startTimeData.startTimestamp + quizData.timerDuration - 10000 <
            Date.now()
        ) {
            // 10 seconds buffer for network latency
            throw new functions.https.HttpsError(
                "failed-precondition",
                "Quiz time is up.",
                { errorCode: "quiz-time-up" }
            );
        }

        const quizTitle = await fetchTitle(quizData);
        const result: QuizResult = { score, maxScore, quizTitle };

        await db
            .collection("users")
            .doc(uid)
            .collection("quizResults")
            .doc(quizId)
            .set(result);

        return JSON.stringify(result);
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while submitting the quiz answers.",
            error
        );
    }
});

export const getQuizHistory = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    try {
        const quizResultsSnapshot = await db
            .collection("users")
            .doc(context.auth.uid)
            .collection("quizResults")
            .get();

        if (!quizResultsSnapshot) {
            throw new functions.https.HttpsError(
                "not-found",
                "Quiz results not found.",
                { errorCode: "quiz-results-not-found" }
            );
        }

        const quizResults = await Promise.all(
            quizResultsSnapshot.docs.map(async (quizResultDoc) => {
                const quizResultData = quizResultDoc.data();

                const quizResult: QuizResult = {
                    quizTitle: quizResultData.quizTitle,
                    score: quizResultData.score,
                    maxScore: quizResultData.maxScore,
                };

                return quizResult;
            })
        );

        return JSON.stringify(quizResults);
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while fetching the quiz results.",
            error
        );
    }
});

export const createQuestion = functions.https.onCall(async (data, context) => {
    const { text, answerList, correctAnswer, value } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    try {
        const userDoc = await db.collection("users").doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError("not-found", "User not found.", {
                errorCode: "user-not-found",
            });
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError(
                "not-found",
                "User data not found.",
                { errorCode: "user-not-found" }
            );
        }

        if (userData.role != "staff") {
            throw new functions.https.HttpsError(
                "permission-denied",
                "User not authorized.",
                { errorCode: "permission-denied" }
            );
        }

        const questionsRef = db.collection("questions");

        const questionDoc = await questionsRef.add({
            text: text ?? "",
            answerList: answerList ?? [],
            correctAnswer: correctAnswer,
            value: value ?? "",
        } as Question);

        return JSON.stringify({ questionId: questionDoc.id });
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while creating the question.",
            error
        );
    }
});
