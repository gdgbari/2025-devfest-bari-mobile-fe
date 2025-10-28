import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_config.g.dart';

@JsonSerializable()
class RemoteConfig extends Equatable {
  final bool leaderboardOpen;
  final String winnerRoom;
  final String winnerTime;
  final String infoTitle;
  final String infoContent;

  const RemoteConfig({
    this.leaderboardOpen = false,
    this.winnerRoom = '',
    this.winnerTime = '',
    this.infoTitle = '',
    this.infoContent = '',
  });

  RemoteConfig copyWith({
    bool? leaderboardOpen,
    String? winnerRoom,
    String? winnerTime,
    String? infoTitle,
    String? infoContent,
  }) {
    return RemoteConfig(
      leaderboardOpen: leaderboardOpen ?? this.leaderboardOpen,
      winnerRoom: winnerRoom ?? this.winnerRoom,
      winnerTime: winnerTime ?? this.winnerTime,
      infoTitle: infoTitle ?? this.infoTitle,
      infoContent: infoContent ?? this.infoContent,
    );
  }

  factory RemoteConfig.fromJson(Map<String, dynamic> json) =>
      _$RemoteConfigFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteConfigToJson(this);

  @override
  List<Object> get props => [
    leaderboardOpen,
    winnerRoom,
    winnerTime,
    infoTitle,
    infoContent,
  ];
}
