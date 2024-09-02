enum RouteNames {
  welcomeRoute(path: '/welcome'),
  loginRoute(path: '/welcome/login'),
  dashboardRoute(path: '/home/dashboard'),
  talkListRoute(path: 'dashboard/talk_list'),
  talkDetailsRoute(path: 'dashboard/talk_list/talk_details'),
  sponsorListRoute(path:'dashboard/sponsor_list'),
  sponsorDetailsRoute(path:'dashboard/sponsor_list/sponsor_details'),
  leaderboardRoute(path: '/home/leaderboard'),
  profileRoute(path: '/home/profile'),
  qrCodeRoute(path: '/home/qr_code'),
  quizRoute(path: '/home/qr_code/quiz');

  final String path;
  const RouteNames({required this.path});
}
