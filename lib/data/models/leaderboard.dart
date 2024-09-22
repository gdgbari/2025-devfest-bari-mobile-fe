import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'leaderboard_entry.dart';

class Leaderboard extends Equatable {
  final String name;
  final List<LeaderboardEntry> entries;

  const Leaderboard({
    this.name = '',
    this.entries = const [],
  });

  Leaderboard copyWith({
    String? name,
    List<LeaderboardEntry>? entries,
  }) {
    return Leaderboard(
      name: name ?? this.name,
      entries: entries ?? this.entries,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'entries': entries.map((x) => x.toMap()).toList(),
    };
  }

  factory Leaderboard.fromMap(Map<String, dynamic> map) {
    return Leaderboard(
      name: map['name'] as String? ?? '',
      entries: List<LeaderboardEntry>.from((map['entries'] ?? [])
          .map((x) => LeaderboardEntry.fromMap(x as Map<String, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Leaderboard.fromJson(String source) =>
      Leaderboard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, entries];
}
