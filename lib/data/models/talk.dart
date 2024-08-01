import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

class Talk extends Equatable {
  final String talkId;
  final String title;
  final String description;
  final String track;
  final String room;
  final DateTime? startTime;
  final DateTime? endTime;
  final Quiz quiz;

  const Talk({
    this.talkId = '',
    this.title = '',
    this.description = '',
    this.track = '',
    this.room = '',
    this.startTime,
    this.endTime,
    this.quiz = const Quiz(),
  });

  Talk copyWith({
    String? talkId,
    String? title,
    String? description,
    String? track,
    String? room,
    DateTime? startTime,
    DateTime? endTime,
    Quiz? quiz,
  }) {
    return Talk(
      talkId: talkId ?? this.talkId,
      title: title ?? this.title,
      description: description ?? this.description,
      track: track ?? this.track,
      room: room ?? this.room,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      quiz: quiz ?? this.quiz,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'talkId': talkId,
      'title': title,
      'description': description,
      'track': track,
      'room': room,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'quiz': quiz.toMap(),
    };
  }

  factory Talk.fromMap(Map<String, dynamic> map) {
    return Talk(
      talkId: map['talkId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      track: map['track'] as String? ?? '',
      room: map['room'] as String? ?? '',
      startTime: DateTime.fromMillisecondsSinceEpoch(
        map['startTime'] as int? ?? 0,
      ),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        map['endTime'] as int? ?? 0,
      ),
      quiz: Quiz.fromMap(map['quiz'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Talk.fromJson(String source) =>
      Talk.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      talkId,
      title,
      description,
      track,
      room,
      startTime,
      endTime,
      quiz,
    ];
  }
}
