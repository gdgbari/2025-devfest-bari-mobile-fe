import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String userId;
  final String name;
  final String surname;
  final String email;
  final Group group;

  const UserProfile({
    this.userId = '',
    this.name = '',
    this.surname = '',
    this.email = '',
    this.group = const Group(),
  });

  UserProfile copyWith({
    String? userId,
    String? name,
    String? surname,
    String? email,
    Group? group,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      group: group ?? this.group,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'surname': surname,
      'email': email,
      'group': group.toMap(),
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      surname: map['surname'] as String? ?? '',
      email: map['email'] as String? ?? '',
      group: Group.fromMap(Map<String, dynamic>.from(map['group'] ?? {})),
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
      name,
      surname,
      email,
      group,
    ];
  }
}
