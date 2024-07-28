import 'dart:convert';

import 'package:equatable/equatable.dart';

class Group extends Equatable {
  final String groupId;
  final String name;
  final String imageUrl;

  const Group({
    this.groupId = '',
    this.name = '',
    this.imageUrl = '',
  });

  Group copyWith({
    String? groupId,
    String? name,
    String? imageUrl,
  }) {
    return Group(
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'groupId': groupId,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      groupId: map['groupId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [groupId, name, imageUrl];
}
