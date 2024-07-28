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
  final List<Quiz> quizList;
  final List<String?> selectedAnswers;
  final QuizStatus status;

  const QuizState({
    this.quizList = const [],
    this.selectedAnswers = const [],
    this.status = QuizStatus.initial,
  });

  QuizState copyWith({
    List<Quiz>? quizList,
    List<String?>? selectedAnswers,
    QuizStatus? status,
  }) {
    return QuizState(
      quizList: quizList ?? this.quizList,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [quizList, selectedAnswers, status];
}
