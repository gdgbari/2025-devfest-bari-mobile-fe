require('module-alias/register');

import { Group } from '@modelsGroup';
import { Question } from '@modelsQuestion';
import { Quiz } from '@modelsQuiz';
import { UserProfile } from '@modelsUserProfile';
import * as admin from 'firebase-admin';
import { DocumentReference } from 'firebase-admin/firestore';
import * as functions from 'firebase-functions';

admin.initializeApp();

const db = admin.firestore();

// Authentication section

async function parseGroupRef(groupRef: DocumentReference): Promise<Group> {
    const groupDoc = await groupRef.get();

    if (!groupDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'Group not found.');
    }

    const groupData = groupDoc.data();

    if (!groupData) {
        throw new functions.https.HttpsError('not-found', 'Group data not found.');
    }

    const group: Group = {
        groupId: groupDoc.id,
        name: groupData.name,
        imageUrl: groupData.imageUrl
    }

    return group;
}

export const getUserProfile = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    try {
        const userDoc = await db.collection('users').doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'User not found.');
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError('not-found', 'User data not found.');
        }

        const group: Group = await parseGroupRef(userData.group);

        const userProfile: UserProfile = {
            userId: userDoc.id,
            email: userData.email,
            name: userData.name,
            surname: userData.surname,
            group: group
        };

        return JSON.stringify(userProfile)
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the user.', error);
    }
});

// Quiz section

async function parseQuestionListRef(questionListRef: DocumentReference[], hideData: boolean = true): Promise<Question[]> {
    const questionList: Question[] = await Promise.all(
        questionListRef.map(async questionRef => {
            const questionDoc = await questionRef.get();

            if (!questionDoc.exists) {
                throw new Error('Question not found');
            }

            const questionData = questionDoc.data();

            if (!questionData) {
                throw new Error('Question not found');
            }

            return {
                questionId: questionDoc.id,
                text: questionData.text,
                answerList: questionData.answerList,
                correctAnswer: !hideData ? questionData.correctAnswer : null,
                value: !hideData ? questionData.value : null
            } as Question;
        })
    );

    return questionList;
}

export const getQuiz = functions.https.onCall(async (data, context) => {
    const { quizId } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    if (!quizId) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid quizId.');
    }

    try {
        const quizDoc = await db.collection('quizzes').doc(quizId).get();

        if (!quizDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Quiz not found.');
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        const questionList: Question[] = await parseQuestionListRef(quizData.questionList);

        const quiz: Quiz = {
            quizId: quizDoc.id,
            questionList: questionList,
            type: quizData.type,
            talkId: quizData.talkId,
            sponsorId: quizData.sponsorId,
            maxScore: quizData.maxScore
        };

        return JSON.stringify(quiz);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the quiz.', error);
    }
});

export const submitQuiz = functions.https.onCall(async (data, context) => {
    const { quizId, answerList } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    const uid = context.auth.uid;

    if (!quizId || !Array.isArray(answerList)) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid quizId and answerList.');
    }

    try {
        const quizDoc = await db.collection('quizzes').doc(quizId).get();

        if (!quizDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Quiz not found.');
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        const answerDoc = await db.collection('users').doc(uid).collection('quizzes').doc(quizId).get();

        if (answerDoc.exists) {
            throw new functions.https.HttpsError('already-exists', 'Quiz already submitted.');
        }

        let score = 0;
        const maxScore = quizData.maxScore;

        if (answerList.length !== quizData.questionList.length) {
            throw new functions.https.HttpsError('invalid-argument', 'The answerList must have the same length as the questionList.');
        }

        const questionList: Question[] = await parseQuestionListRef(quizData.questionList, false);

        questionList.forEach((question: Question, index: number) => {
            if (question.correctAnswer === answerList[index]) {
                score += question.value || 0;
            }
        });

        const result = { score, maxScore };

        await db.collection('users').doc(uid).collection('quizzes').doc(quizId).set(result);

        return JSON.stringify(result);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while submitting the quiz answers.', error);
    }
});
