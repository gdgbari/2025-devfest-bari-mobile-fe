// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:devfest_bari_2024/data.dart';
// import 'package:equatable/equatable.dart';
//
// part 'leaderboard_state.dart';
//
// class QuizCubit extends Cubit<QuizState> {
//   final _quizRepo = QuizRepository();
//   Timer? _timer;
//
//   QuizCubit() : super(const QuizState());
//
//   void resetQuiz() => emit(const QuizState());
//
//   void startTimer() {
//     Duration duration = state.quiz.timerDuration;
//     _timer = Timer.periodic(
//       const Duration(seconds: 1),
//       (_) {
//         if (duration.inSeconds != 0) {
//           duration -= const Duration(seconds: 1);
//           emit(
//             state.copyWith(
//               quiz: state.quiz.copyWith(
//                 timerDuration: duration,
//               ),
//             ),
//           );
//         } else {
//           stopTimer();
//           emit(state.copyWith(status: QuizStatus.timerExpired));
//         }
//       },
//     );
//   }
//
//   void stopTimer() => _timer?.cancel();
//
//   Future<void> getQuiz(String quizId) async {
//     emit(const QuizState().copyWith(status: QuizStatus.fetchInProgress));
//
//     try {
//       final quiz = await _quizRepo.getQuiz(quizId);
//       emit(
//         state.copyWith(
//           status: QuizStatus.fetchSuccess,
//           quiz: quiz,
//           selectedAnswers: List<int?>.generate(
//             quiz.questionList.length,
//             (index) => null,
//           ),
//         ),
//       );
//       startTimer();
//     } catch (e) {
//       emit(state.copyWith(status: QuizStatus.fetchFailure));
//     }
//   }
//
//   void selectAnswer(String quizId, int? answerIndex) {
//     emit(state.copyWith(status: QuizStatus.selectionInProgress));
//     final index = state.quiz.questionList.indexWhere(
//       (quiz) => quiz.questionId == quizId,
//     );
//     final selectedAnswers = List<int?>.from(state.selectedAnswers);
//     selectedAnswers[index] = answerIndex;
//     emit(
//       state.copyWith(
//         status: QuizStatus.selectionSuccess,
//         selectedAnswers: selectedAnswers,
//       ),
//     );
//   }
//
//   Future<void> submitQuiz() async {
//     emit(state.copyWith(status: QuizStatus.submissionInProgress));
//     try {
//       final results = await _quizRepo.submitQuiz(
//         state.quiz.quizId,
//         state.selectedAnswers,
//       );
//       emit(
//         state.copyWith(
//           status: QuizStatus.submissionSuccess,
//           results: results,
//         ),
//       );
//     } catch (e) {
//       emit(state.copyWith(status: QuizStatus.submissionFailure));
//     }
//   }
// }
