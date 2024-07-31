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
                                    value: question.answerList[answerIndex],
                                    groupValue:
                                        state.selectedAnswers[questionIndex],
                                    onChanged: (selectedAnswer) {
                                      context.read<QuizCubit>().selectAnswer(
                                            question.questionId,
                                            selectedAnswer,
                                          );
                                    },
                                    title: answer,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: question.answerList.length,
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
                                    state.quiz.questionList.length - 1
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
