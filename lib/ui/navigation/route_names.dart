enum RouteNames {
  welcomeRoute(path: '/welcome'),
  loginRoute(path: '/welcome/login'),
  leaderboardRoute(path: '/home/leaderboard'),
  profileRoute(path: '/home/profile'),
  qrCodeRoute(path: '/home/qr_code'),
  quizRoute(path: '/home/qr_code/quiz');

  final String path;
  const RouteNames({required this.path});
}
