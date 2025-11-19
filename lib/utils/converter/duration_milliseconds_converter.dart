import 'package:json_annotation/json_annotation.dart';

/// Converter for Duration to/from JSON in milliseconds
/// The backend sends duration values in milliseconds
class DurationMillisecondsConverter implements JsonConverter<Duration, dynamic> {
  const DurationMillisecondsConverter();

  @override
  Duration fromJson(dynamic json) {
    if (json == null) {
      return Duration.zero;
    }
    if (json is int) {
      return Duration(milliseconds: json);
    }
    if (json is num) {
      return Duration(milliseconds: json.toInt());
    }
    return Duration.zero;
  }

  @override
  dynamic toJson(Duration object) {
    return object.inMilliseconds;
  }
}

