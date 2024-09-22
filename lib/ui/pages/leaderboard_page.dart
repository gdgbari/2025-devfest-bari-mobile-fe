import 'package:devfest_bari_2024/logic.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                context.read<AuthenticationCubit>().signOut();
              },
              child: Text(
                'LEADERBOARD',
                style: PresetTextStyle.black15w700.copyWith(
                  color: ColorPalette.coreRed,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
