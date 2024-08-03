import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GroupInfo(group: state.userProfile.group),
                  const SizedBox(height: 20),
                  UserInfo(userProfile: state.userProfile),
                  const SizedBox(height: 20),
                  const Expanded(child: SizedBox()),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        context.read<AuthenticationCubit>().signOut();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'LOGOUT',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
