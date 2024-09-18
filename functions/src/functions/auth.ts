import { Group } from "@models/Group";
import { UserProfile } from "@models/UserProfile";
import { GenericResponse } from "@modelsresponse/GenericResponse";
import { getAuth } from "firebase-admin/auth";
import * as functions from "firebase-functions";
import { db } from "../index";
import { parseGroupRef } from "../utils/firestoreHelpers";
import { serializedErrorResponse, serializedExceptionResponse, serializedSuccessResponse } from "../utils/responseHelper";

export const signUp = functions.https.onCall(async (data, context) => {
    const { name, surname, email, password } = data;

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
            email: userData.email,
            name: userData.name,
            surname: userData.surname,
            group: group,
        };

        return serializedSuccessResponse(userProfile);
    } catch (error) {
        console.error("An error occurred while fetching the user profile.", error);
        return serializedExceptionResponse(error);
    }
});
