import { Quiz } from "@modelsQuiz";
import { Timestamp } from "firebase-admin/firestore";

export interface Talk {
    talkId: string;
    title: string;
    description: string;
    track: string;
    room: string;
    startTime: Timestamp;
    endTime: Timestamp;
    quiz: Quiz | null;
}
