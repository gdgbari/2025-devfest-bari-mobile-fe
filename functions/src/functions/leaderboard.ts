import * as functions from "firebase-functions";
import {serializedErrorResponse, serializedExceptionResponse, serializedSuccessResponse} from "../utils/responseHelper";
import {db} from "../index";
import {Leaderboard} from "@modelsLeaderboard";
import {UserProfile} from "@modelsUserProfile";
import {Group} from "@modelsGroup";
import {QuizResult} from "@modelsQuizResult";
import {GenericResponse} from "@modelsresponse/GenericResponse";
import {parseGroupRef} from "../utils/firestoreHelpers";

export const getLeaderboard = functions.https.onCall(async (_, context) => {
    try {
        const leaderboard: Leaderboard = {
            users: [],
            groups: [],
        };
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
                        role: null
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
            return serializedErrorResponse("groups-not-found", "No group found.");
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

async function _refreshLeaderboard() {
    try {
        const usersCollection = db.collection("users");
        const groupsCollection = db.collection("groups");

        const usersSnapshot = await usersCollection.get();
        const groupsSnapshot = await groupsCollection.get();
        let groupsScore: { [key: string]: number } = {};

        if (!usersSnapshot) {
            return serializedErrorResponse("users-not-found", "No user found.");
        }
        if (!groupsSnapshot) {
            return serializedErrorResponse("groups-not-found", "No group found.");
        }

        for (const userDoc of usersSnapshot.docs) {
            let userAcc = 0;
            let userRef = usersCollection.doc(userDoc.id);
            const userData = userDoc.data();

            await userRef
                .collection("quizResults")
                .get()
                .then((quizResultSnapshot) => {
                    quizResultSnapshot.docs.forEach((quizResultDoc) => {
                        const quizResult = quizResultDoc.data() as QuizResult;
                        userAcc += quizResult.score;
                    });

                    if (userData.group != null) {
                        parseGroupRef(userData.group).then((groupResponse: GenericResponse<Group>) => {
                            const groupData = groupResponse.data as Group;
                            if (!groupsScore[groupData.groupId]) {
                                groupsScore[groupData.groupId] = 0;
                            }
                            groupsScore[groupData.groupId] += userAcc || 0;
                        });
                    }
                });

            functions.logger.log("Updating user ", userDoc.id, " with score ", userAcc);

            await userRef.update({
                score: userAcc
            });
        }


        for (const groupDoc of groupsSnapshot.docs) {
            functions.logger.log("Updating group ", groupDoc.id, " with score ", groupsScore[groupDoc.id] || 0);

            await groupsCollection.doc(groupDoc.id).update({
                score: groupsScore[groupDoc.id] || 0,
            });
        }

        return;
    } catch (error) {
        console.error("An error occurred while refreshing the leaderboard.", error);
        return serializedExceptionResponse(error);
    }
}

// export const refreshLeaderboardScheduled = functions.pubsub.schedule('every 5 seconds').onRun(async (_) => {
//     return _refreshLeaderboard();
// });

export const refreshLeaderboard = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "The request has to be authenticated.");
    }

    const userDoc = await db.collection("users").doc(context.auth.uid).get();

    if (!userDoc.exists) {
        return serializedErrorResponse("user-not-found", "The user does not exist.");
    }

    const userData = userDoc.data();

    if (!userData) {
        return serializedErrorResponse("user-not-found", "The user does not exist.");
    }

    if (userData.role != "staff") {
        return serializedErrorResponse("permission-denied", "User not authorized.");
    }

    functions.logger.log("Leaderboard refresh requested by ", context.auth.uid);

    return _refreshLeaderboard();
});
