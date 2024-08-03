import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
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
                onPressed: () async {
                  // TODO: test something here
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Ehi! Non hai completato il quiz!'),
                      action: SnackBarAction(
                        label: 'RIPRENDI',
                        textColor: Colors.white,
                        onPressed: () {
                          context.pushNamed(RouteNames.quizRoute.name);
                        },
                      ),
                      backgroundColor: Colors.blue.shade800,
                      duration: const Duration(seconds: 30),
                    ),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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
