import 'dart:ui';

import 'package:devfest_bari_2025/ui/theme/color_palette.dart';
import 'package:json_annotation/json_annotation.dart';

/// Converter for Flutter's Color class to/from JSON
/// Supports both string color names and integer values
class ColorConverter implements JsonConverter<Color, dynamic> {
  const ColorConverter();

  @override
  Color fromJson(dynamic json) {
    if (json is String) {
      return _parseColorFromString(json);
    } else if (json is int) {
      return Color(json);
    } else if (json is num) {
      return Color(json.toInt());
    }
    return const Color(0xFF000000); // Default to black
  }

  @override
  dynamic toJson(Color object) {
    return object.toARGB32();
  }

  /// Parse color from string name
  Color _parseColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return ColorPalette.coreRed;
      case 'blue':
        return ColorPalette.coreBlue;
      case 'green':
        return ColorPalette.coreGreen;
      case 'yellow':
        return ColorPalette.coreYellow;
      default:
        return ColorPalette.black;
    }
  }
}
