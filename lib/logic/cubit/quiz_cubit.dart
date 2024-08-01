import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final _quizRepo = QuizRepository();

  QuizCubit() : super(const QuizState());

  Future<void> getQuiz(String quizId) async {
    emit(state.copyWith(status: QuizStatus.fetchInProgress));

    try {
      final quiz = await _quizRepo.getQuiz(quizId);
      emit(
        state.copyWith(
          quiz: quiz,
          selectedAnswers: List<int?>.generate(
            quiz.questionList.length,
            (index) => null,
          ),
          status: QuizStatus.fetchSuccess,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: QuizStatus.fetchFailure));
    }
  }

  void resetAnswers() => emit(
        state.copyWith(
          selectedAnswers: List<int?>.generate(
            state.quiz.questionList.length,
            (index) => null,
          ),
        ),
      );

  void selectAnswer(String quizId, int? answerIndex) {
    emit(state.copyWith(status: QuizStatus.selectionInProgress));
    final index = state.quiz.questionList.indexWhere(
      (quiz) => quiz.questionId == quizId,
    );
    final selectedAnswers = List<int?>.from(state.selectedAnswers);
    selectedAnswers[index] = answerIndex;
    emit(
      state.copyWith(
        selectedAnswers: selectedAnswers,
        status: QuizStatus.selectionSuccess,
      ),
    );
  }

  Future<void> submitQuiz() async {
    emit(state.copyWith(status: QuizStatus.submissionInProgress));
    try {
      await _quizRepo.submitQuiz(state.quiz.quizId, state.selectedAnswers);
      emit(state.copyWith(status: QuizStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: QuizStatus.submissionFailure));
    }
  }
}
