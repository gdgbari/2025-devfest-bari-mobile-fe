import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _topLevelProviders,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'DevFest Bari 2024',
      ),
    );
  }
}

List<BlocProvider> _topLevelProviders = [
  BlocProvider<QuizCubit>(
    lazy: false,
    create: (context) => QuizCubit(),
  ),
];
