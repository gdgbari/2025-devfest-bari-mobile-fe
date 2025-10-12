import 'package:devfest_bari_2025/ui.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable()
class Group extends Equatable {
  final String groupId;
  final String name;
  final String imageUrl;
  final GroupColors colors;
  final int position;
  final int score;

  const Group({
    this.groupId = '',
    this.name = '',
    this.imageUrl = '',
    this.colors = GroupColors.black,
    this.position = 0,
    this.score = 0,
  });

  Group copyWith({
    String? groupId,
    String? name,
    String? imageUrl,
    GroupColors? colors,
    int? position,
    int? score,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      colors: colors ?? this.colors,
      position: position ?? this.position,
      score: score ?? this.score,
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);

  @override
  List<Object> get props {
    return [groupId, name, imageUrl, colors, position, score];
  }
}
