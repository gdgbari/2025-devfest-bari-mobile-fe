import 'dart:convert';

import 'package:devfest_bari_2024/data.dart';
import 'package:equatable/equatable.dart';

class Talk extends Equatable {
  final String talkId;
  final String title;
  final String description;
  final List<Quiz> quizList;
  final int maxScore;

  const Talk({
    this.talkId = '',
    this.title = '',
    this.description = '',
    this.quizList = const [],
    this.maxScore = 0,
  });

  Talk copyWith({
    String? talkId,
    String? title,
    String? description,
    List<Quiz>? quizList,
    int? maxScore,
  }) {
    return Talk(
      talkId: talkId ?? this.talkId,
      title: title ?? this.title,
      description: description ?? this.description,
      quizList: quizList ?? this.quizList,
      maxScore: maxScore ?? this.maxScore,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'talkId': talkId,
      'title': title,
      'description': description,
      'quizList': quizList.map((x) => x.toMap()).toList(),
      'maxScore': maxScore,
    };
  }

  factory Talk.fromMap(Map<String, dynamic> map) {
    return Talk(
      talkId: map['talkId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      quizList: List<Quiz>.from(
        (map['quizList'] as List).map(
          (x) => Quiz.fromMap(x as Map<String, dynamic>? ?? {}),
        ),
      ),
      maxScore: map['maxScore'] as int? ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Talk.fromJson(String source) =>
      Talk.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      talkId,
      title,
      description,
      quizList,
      maxScore,
    ];
  }
}
