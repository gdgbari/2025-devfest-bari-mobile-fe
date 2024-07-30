import { Group } from "@modelsGroup";

export interface UserProfile {
    userId: string;
    email: string;
    name: string;
    surname: string;
    group: Group;
}