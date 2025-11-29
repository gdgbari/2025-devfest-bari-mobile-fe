import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final leaderboardState = context.read<LeaderboardCubit>().state;
    if (leaderboardState.status == LeaderboardStatus.fetchSuccess) {
      context.read<AuthenticationCubit>().updatePosition(
        leaderboardState.currentUser.position,
        leaderboardState.currentGroup.position,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LeaderboardCubit, LeaderboardState>(
      listener: (context, state) {
        if (state.status == LeaderboardStatus.fetchSuccess) {
          context.read<AuthenticationCubit>().updatePosition(
            state.currentUser.position,
            state.currentGroup.position,
          );
        }
      },
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          return ListenableBuilder(
            listenable: GoRouter.of(context).routerDelegate,
            builder: (context, _) {
              final currentLocation = GoRouterState.of(context).uri.path;
              final tabTitle = _getTabTitle(
                widget.navigationShell.currentIndex,
                currentLocation,
                authState.userProfile.nickname,
              );
              final showBackButton = _shouldShowBackButton(currentLocation);

              return Scaffold(
                appBar: AppBar(
                  title: Text(tabTitle, style: PresetTextStyle.black23w500),
                  centerTitle: false,
                  leading: showBackButton
                      ? BackButton(onPressed: () => context.pop())
                      : null,
                  actions: <Widget>[
                    if (widget.navigationShell.currentIndex != 1)
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
                    if (widget.navigationShell.currentIndex == 1)
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
                body: widget.navigationShell,
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
                  currentIndex: widget.navigationShell.currentIndex,
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
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  String _getTabTitle(int tabIndex, String currentPath, String nickname) {
    if (tabIndex == 1) {
      return '@$nickname';
    }

    if (tabIndex == 0) {
      if (currentPath.contains(RouteNames.leaderboardRoute.path)) {
        return 'Leaderboard';
      }
      if (currentPath.contains(RouteNames.activityListRoute.path)) {
        return 'Activities';
      }
      return 'Dashboard';
    }

    return 'DevFest Bari 2025';
  }

  bool _shouldShowBackButton(String currentPath) {
    return currentPath.contains(RouteNames.leaderboardRoute.path) ||
        currentPath.contains(RouteNames.activityListRoute.path);
  }
}
