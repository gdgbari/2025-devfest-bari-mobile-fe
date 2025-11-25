import 'package:devfest_bari_2025/ui.dart';
import 'package:flutter/material.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Activity name', style: PresetTextStyle.black15w500),
            Checkbox(
              value: true,
              onChanged: null,
              fillColor: WidgetStateProperty.all(ColorPalette.coreYellow),
            ),
          ],
        ),
      ),
    );
  }
}
