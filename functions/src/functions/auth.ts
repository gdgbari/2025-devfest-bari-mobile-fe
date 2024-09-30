import { Group } from "@models/Group";
import { UserProfile } from "@models/UserProfile";
import { GenericResponse } from "@modelsresponse/GenericResponse";
import { getAuth } from "firebase-admin/auth";
import * as functions from "firebase-functions";
import { db } from "../index";
import { parseGroupRef } from "../utils/firestoreHelpers";
import { serializedErrorResponse, serializedExceptionResponse, serializedSuccessResponse } from "../utils/responseHelper";
import { user } from "firebase-functions/v1/auth";

export const signUp = functions.https.onCall(async (data, context) => {
    const { name, surname, nickname, email, password } = data;

    try {
        const userRecord = await getAuth()
            .createUser({
                email: email,
                emailVerified: true,
                password: password,
                displayName: name + ' ' + surname,
                disabled: false,
            });

        const uid = userRecord.uid;

        const usersRef = db.collection("users");

        const userDoc = await usersRef.doc(uid).get();

        if (userDoc.exists) {
            return serializedErrorResponse("user-already-registered", "The user is already registered.");
        }

        usersRef.doc(uid).set({
            name: name,
            surname: surname,
            email: email,
            nickname: nickname,
            group: null,
            role: "attendee",
            score: 0
        });

        return serializedSuccessResponse(uid);
    } catch (error) {
        console.error("An error occurred while registering the user.", error);
        return serializedExceptionResponse(error);
    }
});

export const getUserProfile = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        return serializedErrorResponse("unauthenticated", "The request has to be authenticated.");
    }

    try {
        const userDoc = await db.collection("users").doc(context.auth.uid).get();

        if (!userDoc.exists) {
            return serializedErrorResponse("user-not-found", "The user does not exist.");
        }

        const userData = userDoc.data();

        if (!userData) {
            return serializedErrorResponse("user-not-found", "The user does not exist.");
        }

        var group: Group | null = null;

        if (userData.group != null) {
            const groupResponse: GenericResponse<Group> = await parseGroupRef(userData.group);

            if (groupResponse.error) {
                return serializedErrorResponse(groupResponse.error.errorCode, groupResponse.error.details);
            }

            group = groupResponse.data as Group;
        }

        const userProfile: UserProfile = {
            userId: userDoc.id,
            nickname: userData.nickname,
            email: userData.email,
            name: userData.name,
            surname: userData.surname,
            group: group,
            groupId: group ? group.groupId : null,
            position: null,
            score: userData.score,
            role: null
        };

        return serializedSuccessResponse(userProfile);
    } catch (error) {
        console.error("An error occurred while fetching the user profile.", error);
        return serializedExceptionResponse(error);
    }
});

export const redeemAuthCode = functions.https.onCall(async (data, context) => {
    const { code } = data;

    if (!context.auth?.uid) {
        return serializedErrorResponse("unauthenticated", "User must be authenticated.");
    }

    if (!code.startsWith("checkin:")) {
        return serializedErrorResponse("invalid-code", "The code is not a valid check-in code.");
    }

    try {
        const codeParts = code.split(":");
        const codeId = codeParts[codeParts.length - 1];
        const authCodeDoc = await db.collection("authorizationCodes").doc(codeId).get();

        if (!authCodeDoc.exists) {
            return serializedErrorResponse("code-not-found", "The authorization code does not exist.");
        }

        const authCodeData = authCodeDoc.data();
        const userReference = db.collection("users").doc(context.auth.uid);

        if (authCodeData?.expired) {
            if (authCodeData?.user?.path === userReference.path) {
                return serializedSuccessResponse("Code already redeemed by this user.");
            }
            return serializedErrorResponse("code-expired", "The authorization code has expired.");
        }

        const groupReference = db.collection("groups").doc(authCodeData?.group.split("groups/")[1]);

        await db.collection("users").doc(context.auth.uid).set({
            group: groupReference
        }, { merge: true });

        await db.collection("authorizationCodes").doc(codeId).set({
            expired: true
            , user: userReference
        }, { merge: true });

        return serializedSuccessResponse("Code redeemed successfully.");
    } catch (error) {
        console.error("An error occurred while redeeming the authorization code.", error);
        return serializedExceptionResponse(error);
    }
});
