import { Question } from "@modelsQuestion";

export interface Quiz {
    quizId: string;
    type: string;
    talkId: string | null;
    sponsorId: string | null;
    maxScore: number | null;
    isOpen: boolean | null;
    questionList: Question[];
    maxTime: number;
}