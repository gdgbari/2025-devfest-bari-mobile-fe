import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question extends Equatable {
  final String questionId;
  final String text;
  final List<Answer> answerList;

  const Question({
    this.questionId = '',
    this.text = '',
    this.answerList = const [],
  });

  Question copyWith({
    String? questionId,
    String? text,
    List<Answer>? answerList,
  }) {
    return Question(
      questionId: questionId ?? this.questionId,
      text: text ?? this.text,
      answerList: answerList ?? this.answerList,
    );
  }

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);

  @override
  List<Object> get props => [questionId, text, answerList];
}
