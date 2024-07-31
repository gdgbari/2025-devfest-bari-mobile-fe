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
          selectedAnswers: List<String?>.generate(
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
          selectedAnswers: List<String?>.generate(
            state.quiz.questionList.length,
            (index) => null,
          ),
        ),
      );

  void selectAnswer(String quizId, String? answer) {
    emit(state.copyWith(status: QuizStatus.selectionInProgress));
    final index = state.quiz.questionList.indexWhere(
      (quiz) => quiz.questionId == quizId,
    );
    final selectedAnswers = List<String?>.from(state.selectedAnswers);
    selectedAnswers[index] = answer;
    emit(
      state.copyWith(
        selectedAnswers: selectedAnswers,
        status: QuizStatus.selectionSuccess,
      ),
    );
  }
}
