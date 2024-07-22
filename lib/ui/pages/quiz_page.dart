import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class QuizPage extends StatelessWidget {
  final pageController = PageController();

  QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (context, quizIndex) {
                      final quiz = state.quizList[quizIndex];
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(quiz.question),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, answerIndex) {
                                  final answer = quiz.answerList[answerIndex];
                                  return AnswerListTile(
                                    value: quiz.answerList[answerIndex],
                                    groupValue:
                                        state.selectedAnswers[quizIndex],
                                    onChanged: (ans) {
                                      context
                                          .read<QuizCubit>()
                                          .selectAnswer(quiz.quizId, ans);
                                    },
                                    title: answer.text,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: quiz.answerList.length,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: state.quizList.length,
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
                          ),
                          child: const Text(
                            'BACK',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            pageController.page?.round() ==
                                    state.quizList.length - 1
                                ? context
                                    .goNamed(RouteNames.dashboardRoute.name)
                                : pageController.nextPage(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.linear,
                                  );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text(
                            'NEXT',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
