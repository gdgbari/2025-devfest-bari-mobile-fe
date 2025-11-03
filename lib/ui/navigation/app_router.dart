import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  observers: [RouterObserver()],
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.welcomeRoute.path,
  routes: <RouteBase>[
    GoRoute(
      name: RouteNames.noInternetRoute.name,
      path: RouteNames.noInternetRoute.path,
      builder: (context, state) => const NoInternetPage(),
    ),
    GoRoute(
      name: RouteNames.welcomeRoute.name,
      path: RouteNames.welcomeRoute.path,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      name: RouteNames.loginRoute.name,
      path: RouteNames.loginRoute.path,
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      name: RouteNames.signUpRoute.name,
      path: RouteNames.signUpRoute.path,
      builder: (context, state) => SignUpPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          observers: [RouterObserver()],
          navigatorKey: _shellNavigatorKey,
          initialLocation: RouteNames.dashboardRoute.path,
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.dashboardRoute.name,
              path: RouteNames.dashboardRoute.path,
              builder: (context, state) => DashboardPage(),
            ),
            GoRoute(
              name: RouteNames.leaderboardRoute.name,
              path: RouteNames.leaderboardRoute.path,
              builder: (context, state) => LeaderboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [RouterObserver()],
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.profileRoute.name,
              path: RouteNames.profileRoute.path,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      name: RouteNames.qrCodeRoute.name,
      path: RouteNames.qrCodeRoute.path,
      builder: (context, state) => QrCodePage(),
    ),
    GoRoute(
      name: RouteNames.quizRoute.name,
      path: RouteNames.quizRoute.path,
      builder: (context, state) => QuizPage(),
    ),
  ],
);
