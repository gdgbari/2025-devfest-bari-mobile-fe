import 'dart:convert';

import 'package:equatable/equatable.dart';

class ServerError extends Equatable {
  final String code;
  final String message;

  const ServerError({
    this.code = '',
    this.message = '',
  });

  ServerError copyWith({
    String? code,
    String? message,
  }) {
    return ServerError(
      code: code ?? this.code,
      message: message ?? this.message,
    );
  }

  factory ServerError.fromMap(Map<String, dynamic> map) {
    return ServerError(
      code: map['code'] as String? ?? '',
      message: map['message'] as String? ?? '',
    );
  }

  factory ServerError.fromJson(String source) =>
      ServerError.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [code, message];
}
