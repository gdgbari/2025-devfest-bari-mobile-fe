import 'package:devfest_bari_2025/data/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz.g.dart';

@JsonSerializable()
class Quiz extends Equatable {
  final String quizId;
  final String title;
  final String type;
  final List<Question> questionList;
  final Duration timerDuration;

  const Quiz({
    this.quizId = '',
    this.title = 'Quiz',
    this.type = '',
    this.questionList = const [],
    this.timerDuration = const Duration(seconds: 0),
  });

  Quiz copyWith({
    String? quizId,
    String? title,
    String? type,
    int? maxScore,
    List<Question>? questionList,
    Duration? timerDuration,
  }) {
    return Quiz(
      quizId: quizId ?? this.quizId,
      title: title ?? this.title,
      type: type ?? this.type,
      questionList: questionList ?? this.questionList,
      timerDuration: timerDuration ?? this.timerDuration,
    );
  }

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
  
  Map<String, dynamic> toJson() => _$QuizToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      quizId,
      title,
      type,
      questionList,
      timerDuration,
    ];
  }
}
