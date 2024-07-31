enum RouteNames {
  loginRoute(path: '/login'),
  dashboardRoute(path: '/home/dashboard'),
  leaderboardRoute(path: '/home/leaderboard'),
  profileRoute(path: '/home/profile'),
  quizRoute(path: 'dashboard/quiz');

  final String path;
  const RouteNames({required this.path});
}
