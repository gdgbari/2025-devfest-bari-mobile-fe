import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserTile extends StatelessWidget {
  final LeaderboardUser user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final iconColor = switch (user.position) {
      1 => ColorPalette.gold,
      2 => ColorPalette.silver,
      3 => ColorPalette.bronze,
      _ => ColorPalette.black,
    };

    final formattedScore = NumberFormat.decimalPattern().format(user.score);
    
    return CustomCard(
      child: Row(
        children: <Widget>[
          Container(
            color: user.groupColor,
            width: 10,
            height: 50,
          ),
          SizedBox(width: 5),
          SizedBox(
            width: 30,
            child: Center(
              child: user.position < 4
                  ? Icon(
                      Icons.military_tech_outlined,
                      size: 28,
                      color: iconColor,
                    )
                  : Text(
                      '${user.position}',
                      style: PresetTextStyle.black17w500,
                    ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(user.nickname, style: PresetTextStyle.black15w400)),
          SizedBox(width: 10),
          Text(formattedScore, style: PresetTextStyle.black15w700),
          SizedBox(width: 15),
        ],
      ),
    );
  }
}
