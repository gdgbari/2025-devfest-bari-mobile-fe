import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

admin.initializeApp();

const db = admin.firestore();

export const getUserData = functions.https.onCall(async (_, context) => {
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

        const groupRef = userData.group;

        const groupDoc = await groupRef.get('group')

        if (!groupDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Group not found.');
        }

        const groupData = groupDoc.data();

        if (!groupData) {
            throw new functions.https.HttpsError('not-found', 'Group data not found.');
        }

        return {
            userId: userDoc.id,
            email: userData.email,
            name: userData.name,
            surname: userData.surname,
            group: {
                groupId: groupDoc.id,
                name: groupData.name,
                imageUrl: groupData.imageUrl
            }
        };
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the user.', error);
    }
});

export const getTalks = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    try {
        const talksSnapshot = await db.collection('talks').get();

        if (!talksSnapshot) {
            throw new functions.https.HttpsError('not-found', 'Talks not found.');
        }

        const talks: any[] = [];

        talksSnapshot.forEach(doc => {
            const talkData = doc.data();
            talks.push({
                talkId: doc.id,
                title: talkData.title,
                description: talkData.description,
                quizList: talkData.quizList,
                maxScore: talkData.maxScore,
            });
        });

        return { talks };
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the talk quiz.', error);
    }

});

export const getTalkQuiz = functions.https.onCall(async (data, context) => {
    const { talkId } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    if (!talkId) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid talkId.');
    }

    try {
        const talkDoc = await db.collection('talks').doc(talkId).get();

        if (!talkDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Talk not found.');
        }

        const talkData = talkDoc.data();

        if (!talkData || !talkData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        return {
            talkId: talkDoc.id,
            quizList: talkData.quizList.map((quiz: any) => {
                return { ...quiz, correctAnswer: null };
            })
        };
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
        const maxScore = talkData.maxScore;

        if (answerList.length !== talkData.quizList.length) {
            throw new functions.https.HttpsError('invalid-argument', 'The answerList must have the same length as the quiz list.');
        }

        talkData.quizList.forEach((quiz: any, index: number) => {
            if (quiz.correctAnswer === answerList[index]) {
                score += quiz.value;
            }
        });

        const result = { score, maxScore };

        await db.collection('users').doc(uid).collection('talksQuizzes').doc(talkId).set(result);

        return result;
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while submitting the quiz answers.', error);
    }
});

