import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

class Leaderboard extends Equatable {
  final List<UserProfile> users;
  final List<Group> groups;

  const Leaderboard({
    this.users = const [],
    this.groups = const [],
  });

  Leaderboard copyWith({
    List<UserProfile>? users,
    List<Group>? groups,
  }) {
    return Leaderboard(
      users: users ?? this.users,
      groups: groups ?? this.groups,
    );
  }

  factory Leaderboard.fromMap(Map<String, dynamic> map) {
    return Leaderboard(
      users: List<UserProfile>.from(
        (map['users'] ?? [] as List<Map<String, dynamic>>).map<UserProfile>(
          (x) => UserProfile.fromMap(x),
        ),
      ),
      groups: List<Group>.from(
        (map['groups'] ?? [] as List<Map<String, dynamic>>).map<Group>(
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
  List<Object> get props => [users, groups];
}
