import 'package:devfest_bari_2025/ui/theme/color_palette.dart';
import 'package:devfest_bari_2025/ui/theme/preset_text_style.dart';
import 'package:devfest_bari_2025/ui/widgets.dart';
import 'package:flutter/material.dart';

class AnswerListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color selectionColor;
  final bool isSelected;

  const AnswerListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.color = ColorPalette.black,
    this.selectionColor = ColorPalette.coreYellow,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              size: 22,
              color: ColorPalette.coreYellow,
            ),
            SizedBox(width: 10),
            Expanded(child: Text(title, style: PresetTextStyle.black15w400,)),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
