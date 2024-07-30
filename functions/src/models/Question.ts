export interface Question {
    questionId: string;
    text: string;
    answerList: string[];
    correctAnswer: number | null;
    value: number | null;
}
