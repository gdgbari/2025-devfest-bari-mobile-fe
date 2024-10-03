enum RouteNames {
  noInternetRoute(path: '/no_internet'),
  welcomeRoute(path: '/welcome'),
  loginRoute(path: '/welcome/login'),
  signUpRoute(path: '/welcome/sign_up'),
  checkInRoute(path: '/welcome/check_in'),
  leaderboardRoute(path: '/home/leaderboard'),
  profileRoute(path: '/home/profile'),
  qrCodeRoute(path: '/home/qr_code'),
  quizRoute(path: '/home/qr_code/quiz');

  final String path;
  const RouteNames({required this.path});
}
