import * as functions from "firebase-functions";
import {serializedErrorResponse, serializedExceptionResponse, serializedSuccessResponse} from "../utils/responseHelper";
import {db} from "../index";
import {Leaderboard} from "@modelsLeaderboard";
import {LeaderboardEntry} from "@modelsLeaderboardEntry";

export const getLeaderboard = functions.https.onCall(async (data, context) => {
    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "The request has to be authenticated.");
    }

    const leaderboard: Leaderboard = {
        name: "Global",
        entries: new Set<LeaderboardEntry>(),
    };

    try {
        const usersSnapshot = await db.collection("users").get();

        if (!usersSnapshot) {
            return serializedErrorResponse("users-not-found", "No user found.");
        }

        const userList = await Promise.all(
            usersSnapshot.docs.map(async (userDoc) => {
                const userData = userDoc.data();

                const leaderboardEntry = {
                    username: userData.name,
                    score: userData.totalScore,
                };

                leaderboard.entries.add(<LeaderboardEntry>leaderboardEntry);

                return serializedSuccessResponse(leaderboard);
            })
        );

        return serializedSuccessResponse(userList);
    } catch (error) {
        console.error("An error occurred while fetching the sponsor list.", error);
        return serializedExceptionResponse(error);
    }
});