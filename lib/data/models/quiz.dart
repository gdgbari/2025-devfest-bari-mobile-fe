import 'dart:convert';

import 'package:devfest_bari_2024/data/models.dart';
import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String quizId;
  final String type;
  final String talkId;
  final String sponsorId;
  final List<Question> questionList;

  const Quiz({
    this.quizId = '',
    this.type = '',
    this.talkId = '',
    this.sponsorId = '',
    this.questionList = const [],
  });

  Quiz copyWith({
    String? quizId,
    String? type,
    String? talkId,
    String? sponsorId,
    int? maxScore,
    List<Question>? questionList,
  }) {
    return Quiz(
      quizId: quizId ?? this.quizId,
      type: type ?? this.type,
      talkId: talkId ?? this.talkId,
      sponsorId: sponsorId ?? this.sponsorId,
      questionList: questionList ?? this.questionList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizId': quizId,
      'type': type,
      'talkId': talkId,
      'sponsorId': sponsorId,
      'questionList': questionList.map((x) => x.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      quizId: map['quizId'] as String? ?? '',
      type: map['type'] as String? ?? '',
      talkId: map['talkId'] as String? ?? '',
      sponsorId: map['sponsorId'] as String? ?? '',
      questionList: List<Question>.from(
        List<Map<String, dynamic>>.from(
          map['questionList'] ?? [],
        ).map((x) => Question.fromMap(x)),
      ),
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
      type,
      talkId,
      sponsorId,
      questionList,
    ];
  }
}
