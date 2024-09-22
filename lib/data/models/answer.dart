import 'dart:convert';

import 'package:equatable/equatable.dart';

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

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      answerId: map['id'] as String,
      text: map['text'] as String,
    );
  }

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [answerId, text];
}
