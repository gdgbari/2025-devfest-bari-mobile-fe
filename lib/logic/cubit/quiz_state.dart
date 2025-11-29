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
  quizAllSessionsCompleted,
  forbidden,
  unknown,
}

class QuizState extends Equatable {
  final QuizStatus status;
  final QuizError error;
  final Quiz quiz;
  final List<QuizAnswer> selectedAnswers;
  final QuizResults results;
  final String? errorMessage;

  const QuizState({
    this.status = QuizStatus.initial,
    this.error = QuizError.none,
    this.quiz = const Quiz(),
    this.selectedAnswers = const [],
    this.results = const QuizResults(),
    this.errorMessage,
  });

  QuizState copyWith({
    QuizStatus? status,
    QuizError? error,
    Quiz? quiz,
    List<QuizAnswer>? selectedAnswers,
    QuizResults? results,
    String? errorMessage,
  }) {
    return QuizState(
      status: status ?? this.status,
      error: error ?? this.error,
      quiz: quiz ?? this.quiz,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, error, quiz, selectedAnswers, results, errorMessage];
}
