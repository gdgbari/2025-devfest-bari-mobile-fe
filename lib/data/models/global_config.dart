import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_config.g.dart';

@JsonSerializable()
class GlobalConfig extends Equatable {
  final bool leaderboardOpen;
  final String winnerRoom;
  final String winnerTime;
  final String infoTitle;
  final String infoContent;

  const GlobalConfig({
    this.leaderboardOpen = false,
    this.winnerRoom = '',
    this.winnerTime = '',
    this.infoTitle = '',
    this.infoContent = '',
  });

  GlobalConfig copyWith({
    bool? leaderboardOpen,
    String? winnerRoom,
    String? winnerTime,
    String? infoTitle,
    String? infoContent,
  }) {
    return GlobalConfig(
      leaderboardOpen: leaderboardOpen ?? this.leaderboardOpen,
      winnerRoom: winnerRoom ?? this.winnerRoom,
      winnerTime: winnerTime ?? this.winnerTime,
      infoTitle: infoTitle ?? this.infoTitle,
      infoContent: infoContent ?? this.infoContent,
    );
  }

  factory GlobalConfig.fromJson(Map<String, dynamic> json) =>
      _$GlobalConfigFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalConfigToJson(this);

  @override
  List<Object> get props => [
    leaderboardOpen,
    winnerRoom,
    winnerTime,
    infoTitle,
    infoContent,
  ];
}
