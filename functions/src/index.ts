require('module-alias/register');

import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

admin.initializeApp();

const db = admin.firestore();

// Authentication

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

// Quiz

export const getQuiz = functions.https.onCall(async (data, context) => {
    const { quizId } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    if (!quizId) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid talkId.');
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

        return {
            quizId: quizDoc.id,
            questionList: quizData.questionList.map(
                (question: { text: any; answerList: any; }) => ({
                    text: question.text,
                    answerList: question.answerList,
                })
            )
        };
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the talk quiz.', error);
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
            throw new functions.https.HttpsError('invalid-argument', 'The answerList must have the same length as the quiz list.');
        }

        quizData.questionList.forEach((question: any, index: number) => {
            if (question.correctAnswer === answerList[index]) {
                score += question.value;
            }
        });

        const result = { score, maxScore };

        await db.collection('users').doc(uid).collection('quizzes').doc(quizId).set(result);

        return result;
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while submitting the quiz answers.', error);
    }
});

// Talks

export const getTalkList = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    const uid = context.auth.uid;

    try {
        const userDoc = await db.collection('users').doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'User not found.');
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError('not-found', 'User data not found.');
        }

        const talksSnapshot = await db.collection('talks').get();

        if (!talksSnapshot) {
            throw new functions.https.HttpsError('not-found', 'Talks not found.');
        }

        const talkList = await Promise.all(
            talksSnapshot.docs.map(
                async talkDoc => {
                    const talkData = talkDoc.data();

                    const quizRef = talkData.quiz;

                    const quizDoc = await quizRef.get()

                    if (!quizDoc.exists) {
                        throw new functions.https.HttpsError('not-found', 'Quiz not found.');
                    }

                    const quizData = quizDoc.data();

                    const questionListRef = quizData.questionList;

                    const questionListDoc = await questionListRef.get()

                    if (!questionListDoc.exists) {
                        throw new functions.https.HttpsError('not-found', 'Quiz not found.');
                    }

                    const questionListData = questionListDoc.data();

                    const answerDoc = await db.collection('users').doc(uid).collection('quizzes').doc(quizDoc.id).get();

                    const quiz = {
                        quizId: quizDoc.id,
                        questionList: questionListData
                    };

                    return {
                        talkId: talkDoc.id,
                        title: talkData.title,
                        description: talkData.description,
                        track: talkData.track,
                        room: talkData.room,
                        startTime: talkData.startTime,
                        endTime: talkData.endTime,
                        quiz: (answerDoc.exists) ? quiz : null,
                    };
                }
            )
        );

        return talkList;
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the talk quiz.', error);
    }
});