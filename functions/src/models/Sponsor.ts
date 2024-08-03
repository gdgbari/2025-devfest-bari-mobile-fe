import { Quiz } from "@modelsQuiz";

export interface Sponsor {
    sponsorId: string;
    name: string;
    description: string;
    websiteUrl: string;
    quiz: Quiz | null;
}