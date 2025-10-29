import 'package:devfest_bari_2025/logic.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLeaderboardView extends StatelessWidget {
  const UserLeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        final users = state.leaderboard.users;

        return AnimatedContainer(
          duration: Duration(milliseconds: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Your score', style: PresetTextStyle.black23w500),
              SizedBox(height: 10),
              UserTile(user: state.leaderboard.currentUser),
              SizedBox(height: 20),
              Text('Top users', style: PresetTextStyle.black23w500),
              SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index == users.length - 1 ? 40 : 0,
                      ),
                      child: UserTile(user: users[index]),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount: users.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
