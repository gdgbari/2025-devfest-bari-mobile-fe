import {LeaderboardEntry} from "@modelsLeaderboardEntry";

export interface Leaderboard {
    name: string | null;
    entries: Set<LeaderboardEntry>;
}
