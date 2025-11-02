import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leaderboard.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Leaderboard extends Equatable {
  final LeaderboardUser currentUser;
  final List<LeaderboardUser> users;
  final List<LeaderboardGroup> groups;

  const Leaderboard({
    this.currentUser = const LeaderboardUser(),
    this.users = const [],
    this.groups = const [],
  });

  Leaderboard copyWith({
    LeaderboardUser? currentUser,
    List<LeaderboardUser>? users,
    List<LeaderboardGroup>? groups,
    bool? isOpen,
    String? winnerRoom,
    String? winnerTime,
  }) {
    return Leaderboard(
      currentUser: currentUser ?? this.currentUser,
      users: users ?? this.users,
      groups: groups ?? this.groups,
    );
  }

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);

  @override
  List<Object> get props => [currentUser, users, groups];
}
