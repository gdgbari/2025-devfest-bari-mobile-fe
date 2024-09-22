part of 'quiz_cubit.dart';

enum QuizStatus {
  initial,
  fetchInProgress,
  fetchSuccess,
  fetchFailure,
  selectionInProgress,
  selectionSuccess,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  timerExpired,
}

class QuizState extends Equatable {
  final QuizStatus status;
  final Quiz quiz;
  final List<String?> selectedAnswers;
  final QuizResults results;

  const QuizState({
    this.status = QuizStatus.initial,
    this.quiz = const Quiz(),
    this.selectedAnswers = const [],
    this.results = const QuizResults(),
  });

  QuizState copyWith({
    QuizStatus? status,
    Quiz? quiz,
    List<String?>? selectedAnswers,
    QuizResults? results,
  }) {
    return QuizState(
      status: status ?? this.status,
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      results: results ?? this.results,
    );
  }

  @override
  List<Object> get props => [status, quiz, selectedAnswers, results];
}
