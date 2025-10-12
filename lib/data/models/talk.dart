import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talk.g.dart';

@JsonSerializable()
class Talk extends Equatable {
  final String talkId;
  final String title;
  final String description;
  final String track;
  final String room;
  final DateTime? startTime;
  final DateTime? endTime;

  const Talk({
    this.talkId = '',
    this.title = '',
    this.description = '',
    this.track = '',
    this.room = '',
    this.startTime,
    this.endTime,
  });

  Talk copyWith({
    String? talkId,
    String? title,
    String? description,
    String? track,
    String? room,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Talk(
      talkId: talkId ?? this.talkId,
      title: title ?? this.title,
      description: description ?? this.description,
      track: track ?? this.track,
      room: room ?? this.room,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  factory Talk.fromJson(Map<String, dynamic> json) => _$TalkFromJson(json);

  Map<String, dynamic> toJson() => _$TalkToJson(this);

  @override
  List<Object?> get props => [
    talkId,
    title,
    description,
    track,
    room,
    startTime,
    endTime,
  ];
}
