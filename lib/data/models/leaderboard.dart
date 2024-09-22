import 'package:equatable/equatable.dart';

import 'leaderboard_entry.dart';

class Leaderboard extends Equatable {
  final String name;
  final List<LeaderboardEntry> entries;

  const Leaderboard({
    this.name = '',
    this.entries = const [],
  });

  @override
  List<Object?> get props => [name, entries];
}