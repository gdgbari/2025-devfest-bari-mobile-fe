import {UserProfile} from "@modelsUserProfile";
import {Group} from "@modelsGroup";

export interface Leaderboard {
    users: Array<UserProfile>;
    groups: Array<Group>;
}
