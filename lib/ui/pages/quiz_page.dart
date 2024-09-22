import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class QuizPage extends StatelessWidget {
  final pageController = PageController();

  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      listener: _quizListener,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorPalette.black,
            title: Text(
              state.quiz.title,
              style: PresetTextStyle.white21w500,
            ),
            centerTitle: false,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              const Icon(
                Icons.timer_outlined,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _formatTimerDuration(state.quiz.timerDuration),
                  style: PresetTextStyle.white17w400,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, questionIndex) {
                      final question = state.quiz.questionList[questionIndex];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(question.text),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, answerIndex) {
                                  final answer =
                                      question.answerList[answerIndex];
                                  return AnswerListTile(
                                    value: answer.answerId,
                                    groupValue:
                                        state.selectedAnswers[questionIndex],
                                    onChanged: (selectedAnswer) {
                                      context.read<QuizCubit>().selectAnswer(
                                            question.questionId,
                                            selectedAnswer,
                                          );
                                    },
                                    title: answer.text,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: question.answerList.length,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${questionIndex + 1}/${state.quiz.questionList.length}',
                                style: PresetTextStyle.black13w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.quiz.questionList.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            pageController.page?.round() == 0
                                ? GoRouter.of(context).pop()
                                : pageController.previousPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.linear,
                                  );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'INDIETRO',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            if (pageController.page?.round() ==
                                state.quiz.questionList.length - 1) {
                              context.read<QuizCubit>().submitQuiz();
                            } else {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear,
                              );
                            }
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: ColorPalette.coreRed,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'AVANTI',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void _quizListener(
  BuildContext context,
  QuizState state,
) {
  switch (state.status) {
    case QuizStatus.submissionInProgress:
      context.loaderOverlay.show();
      break;
    case QuizStatus.submissionSuccess:
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (_) => QuizResultsDialog(
          onPressed: () => context.goNamed(RouteNames.leaderboardRoute.name),
          content: Text(
            'Punteggio: ${state.results.score}/${state.results.maxScore}',
          ),
        ),
      );
      break;
    case QuizStatus.submissionFailure:
      context.loaderOverlay.hide();
      // TODO: show error message
      break;
    case QuizStatus.timerExpired:
      context.read<QuizCubit>().submitQuiz();
      break;
    default:
      break;
  }
}

String _formatTimerDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).abs().toString();
  final seconds =
      duration.inSeconds.remainder(60).abs().toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
