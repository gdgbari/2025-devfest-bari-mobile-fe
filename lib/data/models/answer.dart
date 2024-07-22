import 'dart:convert';

import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final String ansId;
  final String text;

  const Answer({
    this.ansId = '',
    this.text = '',
  });

  Answer copyWith({
    String? ansId,
    String? text,
  }) {
    return Answer(
      ansId: ansId ?? this.ansId,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ans_id': ansId,
      'text': text,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      ansId: map['ans_id'] as String,
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ansId, text];
}
