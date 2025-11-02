import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remote_config.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RemoteConfig extends Equatable {
  final bool checkInOpen;
  final bool leaderboardOpen;
  final String winnerRoom;
  final String winnerTime;
  final String infoTitle;
  final String infoContent;

  const RemoteConfig({
    this.checkInOpen = false,
    this.leaderboardOpen = false,
    this.winnerRoom = '',
    this.winnerTime = '',
    this.infoTitle = '',
    this.infoContent = '',
  });

  RemoteConfig copyWith({
    bool? checkInOpen,
    bool? leaderboardOpen,
    String? winnerRoom,
    String? winnerTime,
    String? infoTitle,
    String? infoContent,
  }) {
    return RemoteConfig(
      checkInOpen: checkInOpen ?? this.checkInOpen,
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
    checkInOpen,
    leaderboardOpen,
    winnerRoom,
    winnerTime,
    infoTitle,
    infoContent,
  ];
}
