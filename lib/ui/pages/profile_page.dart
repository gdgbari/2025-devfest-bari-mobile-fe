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
            return Column(
              children: <Widget>[
                GroupInfo(group: state.userProfile.group),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        UserInfo(userProfile: state.userProfile),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            context.read<AuthenticationCubit>().signOut();
                          },
                          child: Text(
                            'ESCI',
                            style: PresetTextStyle.black15w700.copyWith(
                              color: ColorPalette.coreRed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
