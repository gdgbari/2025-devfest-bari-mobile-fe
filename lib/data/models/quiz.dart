import 'dart:convert';

import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  final String quizId;
  final String question;
  final List<String> answerList;

  const Quiz({
    this.quizId = '',
    this.question = '',
    this.answerList = const [],
  });

  Quiz copyWith({
    String? quizId,
    String? question,
    List<String>? answerList,
  }) {
    return Quiz(
      quizId: quizId ?? this.quizId,
      question: question ?? this.question,
      answerList: answerList ?? this.answerList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizId': quizId,
      'question': question,
      'answerList': answerList,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      quizId: map['quizId'] as String? ?? '',
      question: map['question'] as String? ?? '',
      answerList: List<String>.from((map['answerList'] as List<String>? ?? [])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) =>
      Quiz.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [quizId, question, answerList];
}
