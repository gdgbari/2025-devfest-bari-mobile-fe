require("module-alias/register");

import * as admin from "firebase-admin";
import { getUserProfile } from "./functions/auth";
import { createTalk, getTalkList } from "./functions/talk";
import { getSponsorList } from "./functions/sponsor";
import {
    getQuizHistory,
    getQuiz,
    createQuiz,
    submitQuiz,
    createQuestion,
    createQuizWithQuestions
} from "./functions/quiz";

admin.initializeApp();
export const db = admin.firestore();

export {
    getUserProfile,
    createTalk,
    getTalkList,
    getSponsorList,
    getQuizHistory,
    getQuiz,
    createQuiz,
    submitQuiz,
    createQuestion,
    createQuizWithQuestions
};
