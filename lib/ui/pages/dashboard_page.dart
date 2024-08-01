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
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  context.read<QuizCubit>()
                    ..resetAnswers()
                    ..getQuiz('osCBQg7hlgDI5ya2iz9l');
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
                  // TODO: test something here
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
      ),
    );
  }
}
