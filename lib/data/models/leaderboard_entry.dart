import 'dart:convert';

import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String username;
  final int score;

  const LeaderboardEntry({
    this.username = '',
    this.score = 0,
  });

  LeaderboardEntry copyWith({
    String? username,
    int? score,
  }) {
    return LeaderboardEntry(
      username: username ?? this.username,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'score': score,
    };
  }

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      username: map['username'] as String? ?? '',
      score: map['score'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeaderboardEntry.fromJson(String source) =>
      LeaderboardEntry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [username];
}
