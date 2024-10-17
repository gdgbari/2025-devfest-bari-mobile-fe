import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContestRules extends Equatable {
  final String title;
  final String content;
  final bool showRules;

  const ContestRules({
    this.title = '',
    this.content = '',
    this.showRules = true,
  });

  ContestRules copyWith({
    String? title,
    String? content,
    bool? showRules,
  }) {
    return ContestRules(
      title: title ?? this.title,
      content: content ?? this.content,
      showRules: showRules ?? this.showRules,
    );
  }

  factory ContestRules.fromMap(Map<String, dynamic> map) {
    return ContestRules(
      title: map['title'] as String? ?? '',
      content: map['content'] as String? ?? '',
      showRules: map['showRules'] as bool? ?? true,
    );
  }

  factory ContestRules.fromJson(String source) =>
      ContestRules.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, content, showRules];
}
