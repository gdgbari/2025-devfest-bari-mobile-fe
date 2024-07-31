import 'dart:convert';

import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String questionId;
  final String text;
  final List<String> answerList;

  const Question({
    this.questionId = '',
    this.text = '',
    this.answerList = const [],
  });

  Question copyWith({
    String? questionId,
    String? text,
    List<String>? answerList,
  }) {
    return Question(
      questionId: questionId ?? this.questionId,
      text: text ?? this.text,
      answerList: answerList ?? this.answerList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'text': text,
      'answerList': answerList,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionId: map['questionId'] as String? ?? '',
      text: map['text'] as String? ?? '',
      answerList: List<String>.from((map['answerList'] as List<String>? ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [questionId, text, answerList];
}
