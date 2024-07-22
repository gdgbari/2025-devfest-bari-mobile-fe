import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final _quizRepo = QuizRepository();

  QuizCubit() : super(const QuizState()) {
    fetchQuizList();
  }

  Future<void> fetchQuizList() async {
    emit(state.copyWith(status: QuizStatus.fetchInProgress));

    try {
      final quizList = await _quizRepo.fetchQuizList();
      emit(
        state.copyWith(
          quizList: quizList,
          selectedAnswers: List<Answer?>.generate(
            quizList.length,
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
          selectedAnswers: List<Answer?>.generate(
            state.quizList.length,
            (index) => null,
          ),
        ),
      );

  void selectAnswer(String quizId, Answer? answer) {
    emit(state.copyWith(status: QuizStatus.selectionInProgress));
    final index = state.quizList.indexWhere((quiz) => quiz.quizId == quizId);
    final selectedAnswers = List<Answer?>.from(state.selectedAnswers) ;
    selectedAnswers[index] = answer;
    emit(
      state.copyWith(
        selectedAnswers: selectedAnswers,
        status: QuizStatus.selectionSuccess,
      ),
    );
  }
}
