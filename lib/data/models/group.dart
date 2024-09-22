import 'dart:convert';

import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String groupId;
  final String name;
  final String imageUrl;
  final int position;
  final int score;

  const Group({
    this.groupId = '',
    this.name = '',
    this.imageUrl = '',
    this.position = 0,
    this.score = 0,
  });

  Group copyWith({
    String? groupId,
    String? name,
    String? imageUrl,
    int? position,
    int? score,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      position: position ?? this.position,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupId': groupId,
      'name': name,
      'imageUrl': imageUrl,
      'position': position,
      'score': score,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      groupId: map['groupId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      position: map['position'] as int? ?? 0,
      score: map['score'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      groupId,
      name,
      imageUrl,
      position,
      score,
    ];
  }
}
