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
  submissionComplete,
  timerInProgress,
  timerExpired,
}

enum QuizError {
  none,
  quizNotFound,
  quizNotOpen,
  quizTimeIsUp,
  quizAlreadySubmitted,
  unknown,
}

class QuizState extends Equatable {
  final QuizStatus status;
  final QuizError error;
  final Quiz quiz;
  final List<String?> selectedAnswers;
  final QuizResults results;

  const QuizState({
    this.status = QuizStatus.initial,
    this.error = QuizError.none,
    this.quiz = const Quiz(),
    this.selectedAnswers = const [],
    this.results = const QuizResults(),
  });

  QuizState copyWith({
    QuizStatus? status,
    QuizError? error,
    Quiz? quiz,
    List<String?>? selectedAnswers,
    QuizResults? results,
  }) {
    return QuizState(
      status: status ?? this.status,
      error: error ?? this.error,
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      results: results ?? this.results,
    );
  }

  @override
  List<Object> get props => [status, error, quiz, selectedAnswers, results];
}
