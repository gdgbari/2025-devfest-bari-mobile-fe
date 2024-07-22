import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:devfest_bari_2024/data.dart';

class Quiz extends Equatable {
  final String quizId;
  final String question;
  final List<Answer> answerList;

  const Quiz({
    this.quizId = '',
    this.question = '',
    this.answerList = const [],
  });

  Quiz copyWith({
    String? quizId,
    String? question,
    List<Answer>? answerList,
  }) {
    return Quiz(
      quizId: quizId ?? this.quizId,
      question: question ?? this.question,
      answerList: answerList ?? this.answerList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quiz_id': quizId,
      'question': question,
      'answer_list': answerList.map((x) => x.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      quizId: map['quiz_id'] as String,
      question: map['question'] as String,
      answerList: List<Answer>.from(
        (map['answer_list'] as List<int>).map<Answer>(
          (x) => Answer.fromMap(x as Map<String, dynamic>),
        ),
      ),
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
