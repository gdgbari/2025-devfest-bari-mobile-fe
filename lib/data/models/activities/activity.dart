import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Activity extends Equatable {
  final String id;
  final String name;
  final bool isCompleted;

  const Activity({this.id = '', this.name = '', this.isCompleted = false});

  Activity copyWith({String? id, String? name, bool? isCompleted}) {
    return Activity(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  List<Object> get props => [id, name, isCompleted];
}
