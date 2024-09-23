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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: group.colors.primaryColor,
            width: width,
            child: Center(
              child: Text(
                '${group.position}°',
                softWrap: false,
                style: PresetTextStyle.white21w500,
              ),
            ),
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
