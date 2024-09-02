import { DocumentReference } from "firebase-admin/firestore";
import { Group } from "@models/Group";
import { Question } from "@models/Question";
import * as functions from "firebase-functions";
import { db } from "../index";

export async function parseGroupRef(
    groupRef: DocumentReference
): Promise<Group> {
    const groupDoc = await groupRef.get();

    if (!groupDoc.exists) {
        throw new functions.https.HttpsError("not-found", "Group not found.", {
            errorCode: "group-not-found",
        });
    }

    const groupData = groupDoc.data();

    if (!groupData) {
        throw new functions.https.HttpsError("not-found", "Group data not found.", {
            errorCode: "group-not-found",
        });
    }

    const group: Group = {
        groupId: groupDoc.id,
        name: groupData.name,
        imageUrl: groupData.imageUrl,
    };

    return group;
}

export async function parseQuestionListRef(
    questionListRef: DocumentReference[],
    hideData: boolean
): Promise<Question[]> {
    const questionList: Question[] = await Promise.all(
        questionListRef.map(async (questionRef) => {
            const questionDoc = await questionRef.get();

            if (!questionDoc.exists) {
                throw new functions.https.HttpsError(
                    "failed-precondition",
                    "Question not found.",
                    { errorCode: "question-not-found" }
                );
            }

            const questionData = questionDoc.data();

            if (!questionData) {
                throw new functions.https.HttpsError(
                    "failed-precondition",
                    "Question not found.",
                    { errorCode: "question-not-found" }
                );
            }

            return {
                questionId: questionDoc.id,
                text: questionData.text,
                answerList: questionData.answerList,
                correctAnswer: !hideData ? questionData.correctAnswer : null,
                value: !hideData ? questionData.value : null,
            } as Question;
        })
    );

    return questionList;
}

export async function fetchTitle(quizData: any): Promise<string> {
    if (quizData.type === "talk") {
        const talkDoc = await db.collection("talks").doc(quizData.talkId).get();

        if (!talkDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Talk not found.", {
                errorCode: "talk-not-found",
            });
        }

        const talkData = talkDoc.data();

        if (!talkData) {
            throw new functions.https.HttpsError(
                "not-found",
                "Talk data not found.",
                { errorCode: "talk-not-found" }
            );
        }

        return talkData.title;
    } else if (quizData.type === "sponsor") {
        const sponsorDoc = await db
            .collection("sponsors")
            .doc(quizData.sponsorId)
            .get();

        if (!sponsorDoc.exists) {
            throw new functions.https.HttpsError("not-found", "Sponsor not found.", {
                errorCode: "sponsor-not-found",
            });
        }

        const sponsorData = sponsorDoc.data();

        if (!sponsorData) {
            throw new functions.https.HttpsError(
                "not-found",
                "Sponsor data not found.",
                { errorCode: "sponsor-not-found" }
            );
        }

        return sponsorData.name;
    } else {
        return quizData.title;
    }
}
