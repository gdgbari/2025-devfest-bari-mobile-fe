import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupLeaderboardView extends StatelessWidget {
  const GroupLeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final groups = state.leaderboard.groups;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Team rankings', style: PresetTextStyle.black23w500),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  ...List<Widget>.generate(groups.length, (index) {
                    return Expanded(
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(
                          bottom: index != groups.length ? 10 : 0,
                        ),
                        child: GroupTile(
                          group: groups[index],
                          maxScore: state.groupMaxScore,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
