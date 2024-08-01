enum RouteNames {
  loginRoute(path: '/login'),
  dashboardRoute(path: '/home/dashboard'),
  leaderboardRoute(path: '/home/leaderboard'),
  profileRoute(path: '/home/profile'),
  qrCodeRoute(path: '/home/qr_code'),
  quizRoute(path: 'dashboard/quiz');

  final String path;
  const RouteNames({required this.path});
}
