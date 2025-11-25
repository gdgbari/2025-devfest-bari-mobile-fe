enum RouteNames {
  noInternetRoute(path: '/no_internet'),
  welcomeRoute(path: '/welcome'),
  loginRoute(path: '/welcome/login'),
  signUpRoute(path: '/welcome/sign_up'),
  dashboardRoute(path: '/home/dashboard'),
  leaderboardRoute(path: '/home/leaderboard'),
  activityListRoute(path: '/home/activity_list'),
  profileRoute(path: '/home/profile'),
  qrCodeRoute(path: '/home/qr_code'),
  quizRoute(path: '/home/qr_code/quiz');

  final String path;
  const RouteNames({required this.path});
}
