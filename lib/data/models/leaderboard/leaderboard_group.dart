import 'dart:ui';

import 'package:devfest_bari_2025/ui.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leaderboard_group.g.dart';

@JsonSerializable()
class LeaderboardGroup extends Equatable {
  final String name;
  final int score;
  final int position;
  @ColorConverter()
  final Color color;
  final int timestamp;

  const LeaderboardGroup({
    this.name = '',
    this.score = 0,
    this.position = 999,
    this.color = ColorPalette.black,
    this.timestamp = 0,
  });

  LeaderboardGroup copyWith({
    String? name,
    int? score,
    int? position,
    Color? color,
    int? timestamp,
  }) {
    return LeaderboardGroup(
      name: name ?? this.name,
      score: score ?? this.score,
      position: position ?? this.position,
      color: color ?? this.color,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory LeaderboardGroup.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardGroupFromJson(json);

  Map<String, dynamic> toJson() => _$LeaderboardGroupToJson(this);

  @override
  List<Object> get props => [name, score, position, color, timestamp];
}
