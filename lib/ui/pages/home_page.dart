import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected) {
          navigationShell.goBranch(0, initialLocation: true);
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          return ListenableBuilder(
            listenable: GoRouter.of(context).routerDelegate,
            builder: (context, _) {
              // Check if we're on the leaderboard route
              final currentLocation = GoRouterState.of(context).uri.path;
              final isOnLeaderboard = currentLocation.contains('/leaderboard');

              final tabTitle = switch (navigationShell.currentIndex) {
                0 => isOnLeaderboard ? 'Leaderboard' : 'Dashboard',
                1 => '@${authState.userProfile.nickname}',
                _ => 'DevFest Bari 2025',
              };

              return Scaffold(
                appBar: AppBar(
                  title: Text(tabTitle, style: PresetTextStyle.black23w500),
                  centerTitle: false,
                  leading: isOnLeaderboard
                      ? BackButton(onPressed: () => context.pop())
                      : null,
                  actions: <Widget>[
                    if (navigationShell.currentIndex != 1)
                      BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
                        builder: (context, state) => IconButton(
                          onPressed: () => showAppInfoDialog(
                            context,
                            state.config.infoTitle,
                            state.config.infoContent,
                          ),
                          icon: const Icon(
                            Icons.info_outline,
                            color: ColorPalette.black,
                          ),
                        ),
                      ),
                    if (navigationShell.currentIndex == 1)
                      IconButton(
                        onPressed: () =>
                            context.read<AuthenticationCubit>().signOut(),
                        icon: const Icon(
                          Icons.logout,
                          color: ColorPalette.black,
                        ),
                      ),
                    SizedBox(width: 4),
                  ],
                ),
                body: navigationShell,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    context.read<QrCodeCubit>().resetQrCode();
                    context.read<QuizCubit>().resetQuiz();
                    context.pushNamed(RouteNames.qrCodeRoute.name);
                  },
                  elevation: 1,
                  backgroundColor: ColorPalette.coreYellow,
                  splashColor: ColorPalette.pastelYellow,
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: ColorPalette.white,
                  selectedItemColor: ColorPalette.coreYellow,
                  selectedLabelStyle: PresetTextStyle.black13w400.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  // unselectedItemColor: Color(0xFF956700),
                  selectedIconTheme: IconThemeData(size: 26),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard_outlined),
                      label: 'Dashboard',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: navigationShell.currentIndex,
                  onTap: (int index) => _onTap(context, index),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
