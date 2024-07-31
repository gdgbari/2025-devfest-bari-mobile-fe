import 'package:devfest_bari_2024/data.dart';
import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {
                context.read<QuizCubit>().resetAnswers();
                context.goNamed(RouteNames.quizRoute.name);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'QUIZ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                final quiz =
                    await QuizRepository().getQuiz('osCBQg7hlgDI5ya2iz9l');
                print(quiz);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                'TEST',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
