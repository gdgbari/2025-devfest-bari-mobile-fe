import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:devfest_bari_2024/ui/navigation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(
            onPressed: () => context.goNamed(RouteNames.dashboardRoute.name),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'DASHBOARD',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
