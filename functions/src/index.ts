require("module-alias/register");

import * as admin from "firebase-admin";
import { getUserProfile, signUp } from "./functions/auth";
import { createTalk, getTalkList } from "./functions/talk";
import { getSponsorList } from "./functions/sponsor";
import {
    getQuizHistory,
    getQuiz,
    createQuiz,
    submitQuiz,
} from "./functions/quiz";

admin.initializeApp();
export const db = admin.firestore();

export {
    signUp,
    getUserProfile,
    createTalk,
    getTalkList,
    getSponsorList,
    getQuizHistory,
    getQuiz,
    createQuiz,
    submitQuiz,
};
