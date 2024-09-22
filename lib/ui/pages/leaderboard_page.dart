import 'package:devfest_bari_2024/data.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              const CustomSegmentedButton(),
              const SizedBox(height: 20),
              Expanded(
                child: PageView(
                  children: const <Widget>[
                    UserLeaderboard(),
                    TeamLeaderboard(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class UserLeaderboard extends StatelessWidget {
  const UserLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        UserTile(
          userProfile: UserProfile(
            nickname: 'pippobaudo123',
            group: Group(
              colors: GroupColors.green,
            ),
            position: 1,
            score: 344,
          ),
        ),
        SizedBox(height: 10),
        UserTile(
          userProfile: UserProfile(
            nickname: 'pippobaudo321',
            group: Group(
              colors: GroupColors.yellow,
            ),
            position: 2,
            score: 286,
          ),
        ),
        SizedBox(height: 10),
        UserTile(
          userProfile: UserProfile(
            nickname: 'pippobaudo000',
            group: Group(
              colors: GroupColors.blue,
            ),
            position: 3,
            score: 254,
          ),
        ),
        SizedBox(height: 10),
        UserTile(
          userProfile: UserProfile(
            nickname: 'pippobaudo777',
            group: Group(
              colors: GroupColors.red,
            ),
            position: 4,
            score: 191,
          ),
        ),
      ],
    );
  }
}

class TeamLeaderboard extends StatelessWidget {
  const TeamLeaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GroupTile(
            group: Group(
              name: 'Polpo',
              colors: GroupColors.blue,
              position: 1,
              score: 100,
            ),
            maxScore: 100,
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GroupTile(
            group: Group(
              name: 'Orecchiette',
              colors: GroupColors.green,
              position: 2,
              score: 80,
            ),
            maxScore: 100,
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GroupTile(
            group: Group(
              name: 'Focaccia',
              colors: GroupColors.red,
              position: 3,
              score: 60,
            ),
            maxScore: 100,
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: GroupTile(
            group: Group(
              name: 'Panzerotto',
              colors: GroupColors.yellow,
              position: 4,
              score: 30,
            ),
            maxScore: 100,
          ),
        ),
      ],
    );
  }
}
