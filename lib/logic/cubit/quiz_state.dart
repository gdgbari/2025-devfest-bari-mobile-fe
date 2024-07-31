part of 'quiz_cubit.dart';

enum QuizStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
  selectionInProgress,
  selectionSuccess,
}

class QuizState extends Equatable {
  final Quiz quiz;
  final List<String?> selectedAnswers;
  final QuizStatus status;

  const QuizState({
    this.quiz = const Quiz(),
    this.selectedAnswers = const [],
    this.status = QuizStatus.initial,
  });

  QuizState copyWith({
    Quiz? quiz,
    List<String?>? selectedAnswers,
    QuizStatus? status,
  }) {
    return QuizState(
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [quiz, selectedAnswers, status];
}
