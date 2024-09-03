import 'dart:convert';

import 'package:devfest_bari_2024/data/models.dart';
import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String quizId;
  final String title;
  final String type;
  final String talkId;
  final String sponsorId;
  final List<Question> questionList;
  final Duration timerDuration;

  const Quiz({
    this.quizId = '',
    this.title = '',
    this.type = '',
    this.talkId = '',
    this.sponsorId = '',
    this.questionList = const [],
    this.timerDuration = const Duration(seconds: 0),
  });

  Quiz copyWith({
    String? quizId,
    String? title,
    String? type,
    String? talkId,
    String? sponsorId,
    int? maxScore,
    List<Question>? questionList,
    Duration? timerDuration,
  }) {
    return Quiz(
      quizId: quizId ?? this.quizId,
      title: title ?? this.title,
      type: type ?? this.type,
      talkId: talkId ?? this.talkId,
      sponsorId: sponsorId ?? this.sponsorId,
      questionList: questionList ?? this.questionList,
      timerDuration: timerDuration ?? this.timerDuration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizId': quizId,
      'title': title,
      'type': type,
      'talkId': talkId,
      'sponsorId': sponsorId,
      'questionList': questionList.map((x) => x.toMap()).toList(),
      'timerDuration': timerDuration.inMilliseconds,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    const backOffTime = 30000;
    final timerDuration = map['timerDuration'] != null
        ? (map['timerDuration'] as int) - backOffTime
        : 0;
    return Quiz(
      quizId: map['quizId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      type: map['type'] as String? ?? '',
      talkId: map['talkId'] as String? ?? '',
      sponsorId: map['sponsorId'] as String? ?? '',
      questionList: List<Question>.from(
        List<Map<String, dynamic>>.from(
          map['questionList'] ?? [],
        ).map((x) => Question.fromMap(x)),
      ),
      timerDuration: Duration(milliseconds: timerDuration),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) =>
      Quiz.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      quizId,
      title,
      type,
      talkId,
      sponsorId,
      questionList,
      timerDuration,
    ];
  }
}
