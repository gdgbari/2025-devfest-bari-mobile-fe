import 'package:devfest_bari_2025/data.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserProfile extends Equatable {
  @JsonKey(name: 'uid')
  final String userId;
  final String nickname;
  final String name;
  final String surname;
  final String email;
  final Group group;
  final int score;
  final int position;
  final bool checkedIn;
  final String role;

  const UserProfile({
    this.userId = '',
    this.nickname = '',
    this.name = '',
    this.surname = '',
    this.email = '',
    this.group = const Group(),
    this.score = 0,
    this.position = 0,
    this.checkedIn = false,
    this.role = 'attendee',
  });

  UserProfile copyWith({
    String? userId,
    String? nickname,
    String? name,
    String? surname,
    String? email,
    Group? group,
    int? score,
    int? position,
    bool? checkedIn,
    String? role,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      group: group ?? this.group,
      score: score ?? this.score,
      position: position ?? this.position,
      checkedIn: checkedIn ?? this.checkedIn,
      role: role ?? this.role,
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  @override
  List<Object> get props {
    return [userId, nickname, name, surname, email, group, score, position, checkedIn, role];
  }
}
