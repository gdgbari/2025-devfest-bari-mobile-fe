import { DocumentReference } from "firebase-admin/firestore";
import { Group } from "@models/Group";
import { Question } from "@models/Question";
import { db } from "../index";
import { errorResponse, successResponse } from "./responseHelper";
import { GenericResponse } from "../models/response/GenericResponse";

export async function parseGroupRef(
    groupRef: DocumentReference
): Promise<GenericResponse<Group>> {
    const groupDoc = await groupRef.get();

    if (!groupDoc.exists) {
        return errorResponse("group-not-found", "The group does not exist.");
    }

    const groupData = groupDoc.data();

    if (!groupData) {
        return errorResponse("group-not-found", "The group data does not exist.");
    }

    const group: Group = {
        groupId: groupDoc.id,
        name: groupData.name,
        imageUrl: groupData.imageUrl,
    };

    return successResponse(group);
}

export async function parseQuestionListRef(
    questionListRef: DocumentReference[],
    hideData: boolean
): Promise<GenericResponse<Question[]>> {
    const questionList: GenericResponse<Question>[] = await Promise.all(
        questionListRef.map(async (questionRef) => {
            const questionDoc = await questionRef.get();

            if (!questionDoc.exists) {
                return errorResponse("question-not-found", "The question does not exist.");
            }

            const questionData = questionDoc.data();

            if (!questionData) {
                return errorResponse("question-not-found", "The question data does not exist.");
            }

            questionData.answerList = questionData.answerList.sort(() => Math.random() - 0.5);

            return successResponse({
                questionId: questionDoc.id,
                text: questionData.text,
                answerList: questionData.answerList,
                correctAnswer: !hideData ? questionData.correctAnswer : null,
                value: !hideData ? questionData.value : null,
            } as Question);
        })
    );

    if (questionList.some((question) => question.error)) {
        return errorResponse("question-not-found", "The question does not exist.");
    }

    return successResponse(questionList.map((question) => question.data as Question));
}

export async function fetchTitle(quizData: any): Promise<GenericResponse<String>> {
    if (quizData.type === "talk") {
        const talkDoc = await db.collection("talks").doc(quizData.talkId).get();

        if (!talkDoc.exists) {
            return errorResponse("talk-not-found", "The talk does not exist.");
        }

        const talkData = talkDoc.data();

        if (!talkData) {
            return errorResponse("talk-not-found", "The talk data does not exist.");
        }

        return successResponse(talkData.title);
    } else if (quizData.type === "sponsor") {
        const sponsorDoc = await db
            .collection("sponsors")
            .doc(quizData.sponsorId)
            .get();

        if (!sponsorDoc.exists) {
            return errorResponse("sponsor-not-found", "The sponsor does not exist.");
        }

        const sponsorData = sponsorDoc.data();

        if (!sponsorData) {
            return errorResponse("sponsor-not-found", "The sponsor data does not exist.");
        }

        return successResponse(sponsorData.name);
    } else {
        return successResponse(quizData.title);
    }
}
