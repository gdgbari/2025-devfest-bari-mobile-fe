require("module-alias/register");

import * as admin from "firebase-admin";
import { getUserProfile, signUp, redeemAuthCode } from "./functions/auth";
import { createTalk, getTalkList } from "./functions/talk";
import { getSponsorList } from "./functions/sponsor";
import { getLeaderboard } from "./functions/leaderboard";
import {
    getQuizHistory,
    getQuiz,
    createQuiz,
    submitQuiz,
    deleteQuiz,
    getQuizList,
    addPointsToUsers,
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
    deleteQuiz,
    getQuizList,
    getLeaderboard,
    redeemAuthCode,
    addPointsToUsers,
};
