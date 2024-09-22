import 'package:devfest_bari_2024/data.dart';
import 'package:devfest_bari_2024/ui.dart';
import 'package:flutter/material.dart';

class GroupTile extends StatelessWidget {
  final Group group;
  final int maxScore;

  const GroupTile({
    super.key,
    required this.group,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    final baseWidth = MediaQuery.of(context).size.width - 40;
    final width = (baseWidth * group.score) / maxScore;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            color: group.colors.primaryColor,
            width: width,
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            text: 'Team ${group.name}',
            style: PresetTextStyle.black17w700,
            children: <InlineSpan>[
              TextSpan(
                text: ': ${group.score} punti',
                style: PresetTextStyle.black17w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
