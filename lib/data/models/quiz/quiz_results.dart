import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_results.g.dart';

@JsonSerializable()
class QuizResults extends Equatable {
  final int score;
  final int maxScore;

  const QuizResults({required this.score, required this.maxScore});

  QuizResults copyWith({int? score, int? maxScore}) {
    return QuizResults(
      score: score ?? this.score,
      maxScore: maxScore ?? this.maxScore,
    );
  }

  factory QuizResults.fromJson(Map<String, dynamic> json) =>
      _$QuizResultsFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultsToJson(this);

  @override
  List<Object> get props => [score, maxScore];
}
