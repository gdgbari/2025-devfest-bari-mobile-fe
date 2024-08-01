import 'package:devfest_bari_2024/logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextButton(
            onPressed: () async {
              context.read<AuthenticationCubit>().signOut();
            },
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            child: const Text(
              'LOGOUT',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
