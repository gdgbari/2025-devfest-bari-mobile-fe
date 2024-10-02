import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

class Leaderboard extends Equatable {
  final LeaderboardUser currentUser;
  final List<LeaderboardUser> users;
  final List<Group> groups;

  const Leaderboard({
    this.currentUser = const LeaderboardUser(),
    this.users = const [],
    this.groups = const [],
  });

  Leaderboard copyWith({
    LeaderboardUser? currentUser,
    List<LeaderboardUser>? users,
    List<Group>? groups,
  }) {
    return Leaderboard(
      currentUser: currentUser ?? this.currentUser,
      users: users ?? this.users,
      groups: groups ?? this.groups,
    );
  }

  factory Leaderboard.fromMap(Map<String, dynamic> map) {
    return Leaderboard(
      currentUser: LeaderboardUser.fromMap(
        Map<String, dynamic>.from(map['currentUser'] ?? {}),
      ),
      users: List<LeaderboardUser>.from(
        List<Map<String, dynamic>>.from(map['users'] ?? []).map(
          (x) => LeaderboardUser.fromMap(x),
        ),
      ),
      groups: List<Group>.from(
        List<Map<String, dynamic>>.from(map['groups'] ?? []).map(
          (x) => Group.fromMap(x),
        ),
      ),
    );
  }

  factory Leaderboard.fromJson(String source) =>
      Leaderboard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [currentUser, users, groups];
}
