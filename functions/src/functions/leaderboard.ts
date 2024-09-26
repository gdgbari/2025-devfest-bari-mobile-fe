import * as functions from "firebase-functions";
import {serializedErrorResponse, serializedExceptionResponse, serializedSuccessResponse} from "../utils/responseHelper";
import {db} from "../index";
import {Leaderboard} from "@modelsLeaderboard";
import {UserProfile} from "@modelsUserProfile";
import {Group} from "@modelsGroup";

export const getLeaderboard = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "The request has to be authenticated.");
    }

    const leaderboard: Leaderboard = {
        users: [],
        groups: [],
    };

    try {
        const usersSnapshot = await db.collection("users").get();

        if (!usersSnapshot) {
            return serializedErrorResponse("users-not-found", "No user found.");
        }

        const users =
            await Promise.all(
                usersSnapshot.docs.map(async (userDoc) => {
                    const userData = userDoc.data();

                    const leaderboardUserEntry: UserProfile = {
                        userId: userDoc.id,
                        nickname: userData.nickname,
                        name: userData.name,
                        surname: userData.surname,
                        email: userData.email,
                        groupId: userData.groupId,
                        group: null,
                        position: null,
                        score: userData.score,
                    }

                    return leaderboardUserEntry;
                })
            );

        users.sort((a, b) => {
            if (a.score && b.score) {
                return b.score - a.score;
            }
            return 0;
        }).forEach((user, index) => {
            user.position = index + 1;
        });

        const groupsSnapshot = await db.collection("groups").get();

        if (!groupsSnapshot) {
            return serializedErrorResponse("groups-not-found", "No groups found.");
        }

        const groups = await Promise.all(
            groupsSnapshot.docs.map(async (groupDoc) => {
                const groupData = groupDoc.data();

                const leaderboardGroupEntry: Group = {
                    groupId: groupDoc.id,
                    name: groupData.name,
                    score: groupData.score,
                    position: null,
                    imageUrl: groupData.imageUrl,
                    color: groupData.color,
                };

                return leaderboardGroupEntry;
            })
        );

        groups.sort((a, b) => {
            if (a.score && b.score) {
                return b.score - a.score;
            }
            return 0;
        }).forEach((group, index) => {
            group.position = index + 1;
        });

        users.forEach(user => leaderboard.users.push(user));
        groups.forEach(group => leaderboard.groups.push(group));

        return serializedSuccessResponse(leaderboard);
    } catch (error) {
        console.error("An error occurred while fetching the leaderboard.", error);
        return serializedExceptionResponse(error);
    }
});