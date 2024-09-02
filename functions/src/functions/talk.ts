import * as functions from "firebase-functions";
import { Timestamp } from "firebase-admin/firestore";
import { db } from "../index";
import { Talk } from "@models/Talk";

export const createTalk = functions.https.onCall(async (data, context) => {
    const { title, description, track, room, startTime, endTime } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    try {
        const userDoc = await db.collection("users").doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError("not-found", "User not found.", {
                errorCode: "user-not-found",
            });
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError(
                "not-found",
                "User data not found.",
                { errorCode: "user-not-found" }
            );
        }

        if (userData.role != "staff") {
            throw new functions.https.HttpsError(
                "permission-denied",
                "User not authorized.",
                { errorCode: "permission-denied" }
            );
        }

        const talksRef = db.collection("talks");

        const talkDoc = await talksRef.add({
            title: title ?? "",
            description: description ?? "",
            track: track ?? "",
            room: room ?? "",
            startTime: Timestamp.fromMillis(startTime ?? 0),
            endTime: Timestamp.fromMillis(endTime ?? 0),
        });

        return JSON.stringify({ talkId: talkDoc.id });
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while creating the talk.",
            error
        );
    }
});

export const getTalkList = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    try {
        const talksSnapshot = await db.collection("talks").get();

        if (!talksSnapshot) {
            throw new functions.https.HttpsError("not-found", "Talks not found.", {
                errorCode: "talks-not-found",
            });
        }

        const talkList = await Promise.all(
            talksSnapshot.docs.map(async (talkDoc) => {
                const talkData = talkDoc.data();

                const talk: Talk = {
                    talkId: talkDoc.id,
                    title: talkData.title,
                    description: talkData.description,
                    track: talkData.track,
                    room: talkData.room,
                    startTime: talkData.startTime.toMillis(),
                    endTime: talkData.endTime.toMillis(),
                };

                return talk;
            })
        );

        return JSON.stringify(talkList);
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while fetching the talk list.",
            error
        );
    }
});
