import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorPalette.gray),
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(15),
            children: <Widget>[
              GroupInfo(group: state.userProfile.group),
              SizedBox(height: 15),
              UserInfo(userProfile: state.userProfile),
              SizedBox(height: 15),
              SocialInfo(),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
