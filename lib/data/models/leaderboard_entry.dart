import 'package:equatable/equatable.dart';

class LeaderboardEntry extends Equatable {
  final String username;

  const LeaderboardEntry({
    this.username = '',
  });

  @override
  List<Object?> get props => [username];
}
