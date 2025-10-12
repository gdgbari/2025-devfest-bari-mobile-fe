import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer extends Equatable {
  final String answerId;
  final String text;

  const Answer({
    this.answerId = '',
    this.text = '',
  });

  Answer copyWith({
    String? answerId,
    String? text,
  }) {
    return Answer(
      answerId: answerId ?? this.answerId,
      text: text ?? this.text,
    );
  }

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  @override
  List<Object> get props => [answerId, text];
}
