import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider>[
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => AuthenticationRepository(
            AuthenticationServiceImpl(),
          ),
        ),
        RepositoryProvider<QuizRepository>(
          create: (_) => QuizRepository(
            QuizServiceImpl(),
          ),
        ),
        RepositoryProvider<LeaderboardRepository>(
          create: (_) => LeaderboardRepository(
            LeaderboardServiceImpl(),
          ),
        ),
        RepositoryProvider<ContestRulesRepository>(
          create: (_) => ContestRulesRepository(
            ContestRulesServiceImpl(),
          ),
        ),
        RepositoryProvider<EasterEggRepository>(
          create: (_) => EasterEggRepository(
            EasterEggServiceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<InternetCubit>(
            lazy: false,
            create: (_) => InternetCubit(),
          ),
          BlocProvider<AuthenticationCubit>(
            lazy: false,
            create: (context) => AuthenticationCubit(
              context.read<AuthenticationRepository>(),
            ),
          ),
          BlocProvider<QrCodeCubit>(
            lazy: false,
            create: (_) => QrCodeCubit(),
          ),
          BlocProvider<QuizCubit>(
            lazy: false,
            create: (context) => QuizCubit(
              context.read<QuizRepository>(),
            ),
          ),
          BlocProvider<LeaderboardCubit>(
            lazy: false,
            create: (context) => LeaderboardCubit(
              context.read<LeaderboardRepository>(),
            ),
          ),
          BlocProvider<ContestRulesCubit>(
            lazy: true,
            create: (context) => ContestRulesCubit(
              context.read<ContestRulesRepository>(),
            ),
          ),
          BlocProvider<EasterEggCubit>(
            lazy: true,
            create: (context) => EasterEggCubit(
              context.read<EasterEggRepository>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
