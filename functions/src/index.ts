import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

const db = admin.firestore();


export const getTalkQuiz = functions.https.onCall(async (data, context) => {
    const { talkId } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    if (!talkId) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid talkId.');
    }

    try {
        const talkDoc = await db.collection('talksQuizzes').doc(talkId).get();

        if (!talkDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Talk not found.');
        }

        const talkData = talkDoc.data();

        if (!talkData || !talkData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        if (talkData.quiz_list) {
            talkData.quiz_list = talkData.quiz_list.map((quiz: any) => {
                return { ...quiz, correct_answer: null };
            });
        }

        return JSON.stringify(talkData);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the talk quiz.', error);
    }
});


export const submitQuizAnswer = functions.https.onCall(async (data, context) => {
    const { talkId, answerList } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    const uid = context.auth.uid;

    if (!talkId || !Array.isArray(answerList)) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid talkId and answerList.');
    }

    try {
        const talkDoc = await db.collection('talksQuizzes').doc(talkId).get();

        if (!talkDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Talk not found.');
        }

        const talkData = talkDoc.data();

        if (!talkData || !talkData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        const answerDoc = await db.collection('users').doc(uid).collection('talksQuizzes').doc(talkId).get();

        if (answerDoc.exists) {
            throw new functions.https.HttpsError('already-exists', 'Quiz already submitted.');
        }

        let score = 0;
        const maxScore = talkData.max_score;

        if (answerList.length !== talkData.quiz_list.length) {
            throw new functions.https.HttpsError('invalid-argument', 'The answerList must have the same length as the quiz list.');
        }

        talkData.quiz_list.forEach((quiz: any, index: number) => {
            if (quiz.correct_answer === answerList[index]) {
                score += quiz.value;
            }
        });

        const result = { score, maxScore };

        await db.collection('users').doc(uid).collection('talksQuizzes').doc(talkId).set(result);

        return JSON.stringify(result);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while submitting the quiz answers.', error);
    }
});

export const getUserData = functions.https.onCall(async (data, context) => {

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }



    try {
        const usersDoc = await db.collection('users').doc(context.auth.uid).get();

        if (!usersDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'User not found.');
        }

        return JSON.stringify(usersDoc.data());
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the user.', error);
    }
});
