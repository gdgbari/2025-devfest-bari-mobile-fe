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
            AuthenticationService(),
          ),
        ),
        RepositoryProvider<QuizRepository>(
          create: (_) => QuizRepository(
            QuizService(),
          ),
        ),
        RepositoryProvider<LeaderboardRepository>(
          create: (_) => LeaderboardRepository(
            LeaderboardService(),
          ),
        ),
        RepositoryProvider<ContestRulesRepository>(
          create: (_) => ContestRulesRepository(
            ContestRulesService(),
          ),
        ),
        RepositoryProvider<EasterEggRepository>(
          create: (_) => EasterEggRepository(
            EasterEggService(),
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
