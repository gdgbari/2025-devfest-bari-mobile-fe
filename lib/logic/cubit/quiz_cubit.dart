import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository _quizRepo;
  Timer? _timer;

  QuizCubit(this._quizRepo) : super(const QuizState());

  void resetQuiz() {
    stopTimer();
    emit(const QuizState());
  }

  void startTimer() {
    emit(state.copyWith(status: QuizStatus.timerInProgress));
    stopTimer();
    Duration duration = state.quiz.timerDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (duration.inSeconds != 0) {
        duration -= const Duration(seconds: 1);
        emit(
          state.copyWith(quiz: state.quiz.copyWith(timerDuration: duration)),
        );
      } else {
        stopTimer();
        emit(state.copyWith(status: QuizStatus.timerExpired));
      }
    });
  }

  void stopTimer() => _timer?.cancel();

  Future<void> getQuiz(String quizCode) async {
    emit(const QuizState().copyWith(status: QuizStatus.fetchInProgress));

    try {
      final quiz = await _quizRepo.getQuiz(quizCode);
      emit(
        state.copyWith(
          status: QuizStatus.fetchSuccess,
          quiz: quiz,
          selectedAnswers: [],
        ),
      );
      startTimer();
    } on QuizNotFoundError {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.quizNotFound,
        ),
      );
    } on QuizNotOpenError {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.quizNotOpen,
        ),
      );
    } on QuizTimeIsUpError {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.quizTimeIsUp,
        ),
      );
    } on QuizAlreadySubmittedError {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.quizAlreadySubmitted,
        ),
      );
    } on QuizAllSessionsCompletedError {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.quizAllSessionsCompleted,
        ),
      );
    } on QuizForbiddenError catch (e) {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.forbidden,
          errorMessage: e.message,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: QuizStatus.fetchFailure,
          error: QuizError.unknown,
        ),
      );
    }
  }

  void selectAnswer(String questionId, String? answerId) {
    emit(state.copyWith(status: QuizStatus.selectionInProgress));

    // Remove existing answer for this question if any
    final updatedAnswers = state.selectedAnswers
        .where((answer) => answer.questionId != questionId)
        .toList();

    // Add new answer if not null
    if (answerId != null) {
      updatedAnswers.add(
        QuizAnswer(questionId: questionId, answerId: answerId),
      );
    }

    emit(
      state.copyWith(
        status: QuizStatus.selectionSuccess,
        selectedAnswers: updatedAnswers,
      ),
    );
  }

  Future<void> submitQuiz() async {
    emit(state.copyWith(status: QuizStatus.submissionInProgress));
    try {
      final results = await _quizRepo.submitQuiz(
        state.quiz.quizId,
        state.selectedAnswers,
      );
      emit(
        state.copyWith(status: QuizStatus.submissionSuccess, results: results),
      );
    } on QuizNotFoundError {
      emit(
        state.copyWith(
          status: QuizStatus.submissionFailure,
          error: QuizError.quizNotFound,
        ),
      );
    } on QuizNotOpenError {
      emit(
        state.copyWith(
          status: QuizStatus.submissionFailure,
          error: QuizError.quizNotOpen,
        ),
      );
    } on QuizTimeIsUpError {
      emit(
        state.copyWith(
          status: QuizStatus.submissionFailure,
          error: QuizError.quizTimeIsUp,
        ),
      );
    } on QuizAlreadySubmittedError {
      emit(
        state.copyWith(
          status: QuizStatus.submissionFailure,
          error: QuizError.quizAlreadySubmitted,
        ),
      );
    } on QuizForbiddenError catch (e) {
      emit(
        state.copyWith(
          status: QuizStatus.submissionFailure,
          error: QuizError.forbidden,
          errorMessage: e.message,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: QuizStatus.submissionFailure,
          error: QuizError.unknown,
        ),
      );
    }
  }

  void completeSubmission() {
    stopTimer();
    emit(state.copyWith(status: QuizStatus.submissionComplete));
  }
}
