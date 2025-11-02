import 'dart:ui';

import 'package:devfest_bari_2025/ui.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LeaderboardUser extends Equatable {
  final String nickname;
  final int score;
  final int position;
  @ColorConverter()
  final Color groupColor;
  final int timestamp;

  const LeaderboardUser({
    this.nickname = '',
    this.score = 0,
    this.position = 999,
    this.groupColor = ColorPalette.black,
    this.timestamp = 0,
  });

  LeaderboardUser copyWith({
    String? nickname,
    int? score,
    int? position,
    Color? groupColor,
    int? timestamp,
  }) {
    return LeaderboardUser(
      nickname: nickname ?? this.nickname,
      score: score ?? this.score,
      position: position ?? this.position,
      groupColor: groupColor ?? this.groupColor,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardUserFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardUserToJson(this);

  @override
  List<Object> get props => [nickname, score, position, groupColor, timestamp];
}
