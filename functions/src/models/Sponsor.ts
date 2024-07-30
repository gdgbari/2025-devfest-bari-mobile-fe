import { Quiz } from "@modelsQuiz";

export interface Sponsor {
    sponsorId: string;
    name: string;
    description: string;
    websiteUrl: string;
    // location: string;
    quiz: Quiz | null;
}