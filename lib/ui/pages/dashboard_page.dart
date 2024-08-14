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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () => context.pushNamed(
                    RouteNames.talkListRoute.name,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Center(
                      child: Text(
                        'Lista dei talk',
                        style: PresetTextStyle.white21w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => context.pushNamed(
                    RouteNames.sponsorListRoute.name,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Center(
                      child: Text(
                        'Lista degli sponsor',
                        style: PresetTextStyle.white21w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
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
                  child: const SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Center(
                      child: Text(
                        'SnackBar alert',
                        style: PresetTextStyle.white21w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () async {
                    // TODO: test something here
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const SizedBox(
                    height: 50,
                    width: double.maxFinite,
                    child: Center(
                      child: Text(
                        'Test',
                        style: PresetTextStyle.white21w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
