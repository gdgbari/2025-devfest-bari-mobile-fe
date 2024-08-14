import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteNames.loginRoute.path,
  routes: <RouteBase>[
    GoRoute(
      name: RouteNames.loginRoute.name,
      path: RouteNames.loginRoute.path,
      builder: (context, state) => LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavigationBarPage(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          initialLocation: RouteNames.dashboardRoute.path,
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.dashboardRoute.name,
              path: RouteNames.dashboardRoute.path,
              builder: (context, state) => const DashboardPage(),
              routes: <RouteBase>[
                GoRoute(
                  name: RouteNames.talkListRoute.name,
                  path: RouteNames.talkListRoute.path,
                  builder: (context, state) => const TalkListPage(),
                ),
                GoRoute(
                  name: RouteNames.talkDetailsRoute.name,
                  path: RouteNames.talkDetailsRoute.path,
                  builder: (context, state) => const TalkDetailsPage(),
                ),
                GoRoute(
                  name: RouteNames.sponsorListRoute.name,
                  path: RouteNames.sponsorListRoute.path,
                  builder: (context, state) => const SponsorListPage(),
                ),
                GoRoute(
                  name: RouteNames.sponsorDetailsRoute.name,
                  path: RouteNames.sponsorDetailsRoute.path,
                  builder: (context, state) => const SponsorDetailsPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              name: RouteNames.leaderboardRoute.name,
              path: RouteNames.leaderboardRoute.path,
              builder: (context, state) => const LeaderboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
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
