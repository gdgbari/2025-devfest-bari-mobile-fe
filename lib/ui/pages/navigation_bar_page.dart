import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationBarPage extends StatelessWidget {
  const NavigationBarPage({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'DevFest Bari 2024',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(RouteNames.qrCodeRoute.name);
            },
            icon: const Icon(
              Icons.photo_camera_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
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
