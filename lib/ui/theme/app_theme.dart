import 'package:devfest_bari_2025/ui/theme/color_palette.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: ColorPalette.gray,
  appBarTheme: const AppBarTheme(
    backgroundColor: ColorPalette.gray,
    surfaceTintColor: Colors.transparent,
  ),
  dialogTheme: const DialogThemeData(
    backgroundColor: ColorPalette.white,
    surfaceTintColor: Colors.transparent,
  ),
);
