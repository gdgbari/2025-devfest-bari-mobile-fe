import * as functions from "firebase-functions";
import { DocumentReference } from "firebase-admin/firestore";
import { Question } from "@models/Question";
import { Quiz } from "@models/Quiz";
import { QuizResult } from "@models/QuizResult";
import { QuizStartTime } from "@models/QuizStartTime";
import { parseQuestionListRef, fetchTitle } from "../utils/firestoreHelpers";
import { db } from "../index";
import { serializedErrorResponse, serializedSuccessResponse, serializedExceptionResponse } from "../utils/responseHelper";
import { GenericResponse } from "@modelsresponse/GenericResponse";

export const createQuiz = functions.https.onCall(async (data, context) => {
    const { questionIdList, type, talkId, sponsorId, quizTitle } = data;

    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "User must be authenticated.");
    }

    try {
        const userDoc = await db.collection("users").doc(context.auth.uid).get();

        if (!userDoc.exists) {
            return serializedErrorResponse("user-not-found", "User not found.");
        }

        const userData = userDoc.data();

        if (!userData) {
            return serializedErrorResponse("user-not-found", "User data not found.");
        }

        if (userData.role != "staff") {
            return serializedErrorResponse("permission-denied", "User not authorized.");
        }

        const quizRef = db.collection("quizzes");

        const questionListRef: DocumentReference[] = (
            questionIdList as string[]
        ).map((docId: string) => db.collection("questions").doc(docId));

        const questionListResponse = await parseQuestionListRef(questionListRef, false);

        if (questionListResponse.error) {
            return serializedErrorResponse(questionListResponse.error.errorCode, questionListResponse.error.details);
        }

        const questionList: Question[] = questionListResponse.data as Question[];

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

        return serializedSuccessResponse({ quizId: quizDoc.id });
    } catch (error) {
        console.error("An error occurred while creating the quiz.", error);
        return serializedExceptionResponse(error);
    }
});

export const getQuiz = functions.https.onCall(async (data, context) => {
    const { quizId } = data;

    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "User must be authenticated.");
    }

    const uid = context.auth.uid;

    if (!quizId) {
        return serializedErrorResponse("invalid-argument", "The function must be called with a valid quizId.");
    }

    try {
        const quizDoc = await db.collection("quizzes").doc(quizId).get();

        if (!quizDoc.exists) {
            return serializedErrorResponse("quiz-not-found", "Quiz not found.");
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            return serializedErrorResponse("quiz-not-open", "Quiz is not open.");
        }

        const questionListResponse: GenericResponse<Question[]> = await parseQuestionListRef(
            quizData.questionList,
            true
        );

        if (questionListResponse.error) {
            return serializedErrorResponse(questionListResponse.error.errorCode, questionListResponse.error.details);
        }

        const questionList: Question[] = questionListResponse.data as Question[];

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
                return serializedErrorResponse("quiz-start-time-not-found", "Quiz start time for user not found.");
            }

            quiz.timerDuration -= Date.now() - startTimeData.startTimestamp;

            if (quiz.timerDuration <= 0) {
                return serializedErrorResponse("quiz-time-up", "Quiz time is up.");
            }
        }

        return serializedSuccessResponse(quiz);
    } catch (error) {
        console.error("An error occurred while fetching the quiz.", error);
        return serializedExceptionResponse(error);
    }
});

export const submitQuiz = functions.https.onCall(async (data, context) => {
    const { quizId, answerList } = data;

    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "User must be authenticated.");
    }

    const uid = context.auth.uid;

    if (!quizId || !Array.isArray(answerList)) {
        return serializedErrorResponse("invalid-argument", "The function must be called with a valid quizId and answerList.");
    }

    try {
        const quizDoc = await db.collection("quizzes").doc(quizId).get();

        if (!quizDoc.exists) {
            return serializedErrorResponse("quiz-not-found", "Quiz not found.");
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            return serializedErrorResponse("quiz-not-open", "Quiz is not open.");
        }

        const answerDoc = await db
            .collection("users")
            .doc(uid)
            .collection("quizResults")
            .doc(quizId)
            .get();

        if (answerDoc.exists) {
            return serializedErrorResponse("quiz-already-submitted", "Quiz already submitted.");
        }

        let score = 0;
        const maxScore = quizData.maxScore;

        if (answerList.length !== quizData.questionList.length) {
            return serializedErrorResponse("invalid-argument", "The answerList must have the same length as the questionList.");
        }

        const questionListResponse: GenericResponse<Question[]> = await parseQuestionListRef(
            quizData.questionList,
            false
        );

        if (questionListResponse.error) {
            return serializedErrorResponse(questionListResponse.error.errorCode, questionListResponse.error.details);
        }

        const questionList: Question[] = questionListResponse.data as Question[];

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
            return serializedErrorResponse("quiz-start-time-not-found", "Quiz start time for user not found.");
        }

        const startTimeData = startTimeDoc.data();

        if (!startTimeData) {
            return serializedErrorResponse("quiz-start-time-not-found", "Quiz start time for user not found.");
        }

        if (
            startTimeData.startTimestamp + quizData.timerDuration - 10000 <
            Date.now()
        ) {
            // 10 seconds buffer for network latency
            return serializedErrorResponse("quiz-time-up", "Quiz time is up.");
        }

        const quizTitleResponse = await fetchTitle(quizData);

        if (quizTitleResponse.error) {
            return serializedErrorResponse(quizTitleResponse.error.errorCode, quizTitleResponse.error.details);
        }

        const quizTitle: string = quizTitleResponse.data as string;

        const result: QuizResult = { score, maxScore, quizTitle: quizTitle };

        await db
            .collection("users")
            .doc(uid)
            .collection("quizResults")
            .doc(quizId)
            .set(result);

        return serializedSuccessResponse(result);
    } catch (error) {
        console.error("An error occurred while submitting the quiz.", error);
        return serializedExceptionResponse(error);
    }
});

export const getQuizHistory = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "User must be authenticated.");
    }

    try {
        const quizResultsSnapshot = await db
            .collection("users")
            .doc(context.auth.uid)
            .collection("quizResults")
            .get();

        if (!quizResultsSnapshot) {
            return serializedErrorResponse("quiz-results-not-found", "Quiz results not found.");
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

        return serializedSuccessResponse(quizResults);
    } catch (error) {
        console.error("An error occurred while fetching the quiz history.", error);
        return serializedExceptionResponse(error);
    }
});

export const createQuestion = functions.https.onCall(async (data, context) => {
    const { text, answerList, correctAnswer, value } = data;

    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "User must be authenticated.");
    }

    try {
        const userDoc = await db.collection("users").doc(context.auth.uid).get();

        if (!userDoc.exists) {
            return serializedErrorResponse("user-not-found", "User not found.");
        }

        const userData = userDoc.data();

        if (!userData) {
            return serializedErrorResponse("user-not-found", "User data not found.");
        }

        if (userData.role != "staff") {
            return serializedErrorResponse("permission-denied", "User not authorized.");
        }

        const questionsRef = db.collection("questions");

        const questionDoc = await questionsRef.add({
            text: text ?? "",
            answerList: answerList ?? [],
            correctAnswer: correctAnswer,
            value: value ?? "",
        } as Question);

        return serializedSuccessResponse({ questionId: questionDoc.id });
    } catch (error) {
        console.error("An error occurred while creating the question.", error);
        return serializedExceptionResponse(error);
    }
});
