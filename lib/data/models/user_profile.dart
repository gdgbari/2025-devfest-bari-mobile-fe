import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId;
  final String nickname;
  final String name;
  final String surname;
  final String email;
  final Group group;
  final int position;
  final int score;

  const UserProfile({
    this.userId = '',
    this.nickname = '',
    this.name = '',
    this.surname = '',
    this.email = '',
    this.group = const Group(),
    this.position = 0,
    this.score = 0,
  });

  UserProfile copyWith({
    String? userId,
    String? nickname,
    String? name,
    String? surname,
    String? email,
    Group? group,
    int? position,
    int? score,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      group: group ?? this.group,
      position: position ?? this.position,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'nickname': nickname,
      'name': name,
      'surname': surname,
      'email': email,
      'group': group.toMap(),
      'position': position,
      'score': score,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'] as String? ?? '',
      nickname: map['nickname'] as String? ?? '',
      name: map['name'] as String? ?? '',
      surname: map['surname'] as String? ?? '',
      email: map['email'] as String? ?? '',
      group: Group.fromMap(Map<String, dynamic>.from(map['group'] ?? {})),
      position: map['position'] as int? ?? 0,
      score: map['score'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      userId,
      nickname,
      name,
      surname,
      email,
      group,
      position,
      score,
    ];
  }
}
