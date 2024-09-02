import * as functions from "firebase-functions";
import { Group } from "@models/Group";
import { UserProfile } from "@models/UserProfile";
import { parseGroupRef } from "../utils/firestoreHelpers";
import { db } from "../index";
import { serializedErrorResponse, serializedSuccessResponse, serializedExceptionResponse } from "../utils/responseHelper";
import { GenericResponse } from "@modelsresponse/GenericResponse";

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

        const groupResponse: GenericResponse<Group> = await parseGroupRef(userData.group);

        if (groupResponse.error) {
            return serializedErrorResponse(groupResponse.error.errorCode, groupResponse.error.details);
        }

        const group: Group = groupResponse.data as Group;

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
