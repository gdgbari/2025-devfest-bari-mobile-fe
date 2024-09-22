import 'dart:ui';

import 'package:devfest_bari_2024/ui.dart';

enum GroupColors {
  blue(
    primaryColor: ColorPalette.coreBlue,
    secondaryColor: ColorPalette.pastelBlue,
  ),
  green(
    primaryColor: ColorPalette.coreGreen,
    secondaryColor: ColorPalette.pastelGreen,
  ),
  red(
    primaryColor: ColorPalette.coreRed,
    secondaryColor: ColorPalette.pastelRed,
  ),
  yellow(
    primaryColor: ColorPalette.coreYellow,
    secondaryColor: ColorPalette.pastelYellow,
  );

  final Color primaryColor;
  final Color secondaryColor;

  const GroupColors({
    required this.primaryColor,
    required this.secondaryColor,
  });
}
