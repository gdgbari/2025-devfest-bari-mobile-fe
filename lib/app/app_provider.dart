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
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(
            UserServiceImpl(),
          ),
        ),
        RepositoryProvider<RemoteConfigRepository>(
          create: (_) => RemoteConfigRepository(
            RemoteConfigServiceImpl(),
          ),
        ),
        RepositoryProvider<QuizRepository>(
          create: (_) => QuizRepository(
            QuizServiceMock(),
          ),
        ),
        RepositoryProvider<LeaderboardRepository>(
          create: (_) => LeaderboardRepository(
            LeaderboardServiceMock(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: <BlocProvider>[
              BlocProvider<InternetCubit>(
                lazy: false,
                create: (_) => InternetCubit(),
              ),
              BlocProvider<AuthenticationCubit>(
                lazy: false,
                create: (context) => AuthenticationCubit(
                  context.read<AuthenticationRepository>(),
                  context.read<UserRepository>(),
                ),
              ),
              BlocProvider<RemoteConfigCubit>(
                lazy: false,
                create: (_) => RemoteConfigCubit(
                  context.read<RemoteConfigRepository>(),
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
            ],
            child: child,
          );
        }
      ),
    );
  }
}
