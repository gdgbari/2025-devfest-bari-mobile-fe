import 'dart:convert';

import 'package:equatable/equatable.dart';

class QuizResults extends Equatable {
  final int score;
  final int maxScore;

  const QuizResults({
    this.score = -1,
    this.maxScore = -1,
  });

  QuizResults copyWith({
    int? score,
    int? maxScore,
  }) {
    return QuizResults(
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'score': score,
      'maxScore': maxScore,
    };
  }

  factory QuizResults.fromMap(Map<String, dynamic> map) {
    return QuizResults(
      score: map['score'] as int? ?? -1,
      maxScore: map['maxScore'] as int? ?? -1,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizResults.fromJson(String source) =>
      QuizResults.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [score, maxScore];
}
