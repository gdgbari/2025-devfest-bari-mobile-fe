enum RouteNames {
  loginRoute(path: '/login'),
  dashboardRoute(path: '/home/dashboard'),
  leaderboardRoute(path: '/home/leaderboard'),
  challengeRoute(path: '/home/challenge'),
  quizRoute(path: 'dashboard/quiz');

  final String path;
  const RouteNames({required this.path});
}