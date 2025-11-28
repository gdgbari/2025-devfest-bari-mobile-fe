import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_answer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QuizAnswer extends Equatable {
  final String questionId;
  final String answerId;

  const QuizAnswer({required this.questionId, required this.answerId});

  factory QuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerToJson(this);

  @override
  List<Object> get props => [questionId, answerId];
}
