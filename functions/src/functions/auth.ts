import * as functions from "firebase-functions";
import { Group } from "@models/Group";
import { UserProfile } from "@models/UserProfile";
import { parseGroupRef } from "../utils/firestoreHelpers";
import { db } from "../index";

export const getUserProfile = functions.https.onCall(async (_, context) => {
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

        const group: Group = await parseGroupRef(userData.group);

        const userProfile: UserProfile = {
            userId: userDoc.id,
            email: userData.email,
            name: userData.name,
            surname: userData.surname,
            group: group,
        };

        return JSON.stringify(userProfile);
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while fetching the user.",
            error
        );
    }
});
