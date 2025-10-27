import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

/// Converter for Flutter's Color class to/from JSON
class ColorConverter implements JsonConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromJson(int json) {
    return Color(json);
  }

  @override
  int toJson(Color object) {
    return object.toARGB32();
  }
}
