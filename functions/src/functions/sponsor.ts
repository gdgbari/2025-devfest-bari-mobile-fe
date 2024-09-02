import * as functions from "firebase-functions";
import { Sponsor } from "@models/Sponsor";
import { db } from "../index";

export const getSponsorList = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError(
            "unauthenticated",
            "User must be authenticated.",
            { errorCode: "unauthenticated" }
        );
    }

    try {
        const sponsorsSnapshot = await db.collection("sponsors").get();

        if (!sponsorsSnapshot) {
            throw new functions.https.HttpsError("not-found", "Sponsors not found.", {
                errorCode: "sponsors-not-found",
            });
        }

        const sponsorList = await Promise.all(
            sponsorsSnapshot.docs.map(async (sponsorDoc) => {
                const sponsorData = sponsorDoc.data();

                const sponsor: Sponsor = {
                    sponsorId: sponsorDoc.id,
                    name: sponsorData.name,
                    description: sponsorData.description,
                    websiteUrl: sponsorData.websiteUrl,
                };

                return sponsor;
            })
        );

        return JSON.stringify(sponsorList);
    } catch (error) {
        console.log(error);
        throw new functions.https.HttpsError(
            "internal",
            "An error occurred while fetching the sponsor list.",
            error
        );
    }
});
