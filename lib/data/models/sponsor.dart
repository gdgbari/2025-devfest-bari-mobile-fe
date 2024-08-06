import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sponsor extends Equatable {
  final String sponsorId;
  final String name;
  final String description;
  final String websiteUrl;

  const Sponsor({
    this.sponsorId = '',
    this.name = '',
    this.description = '',
    this.websiteUrl = '',
  });

  Sponsor copyWith({
    String? sponsorId,
    String? name,
    String? description,
    String? websiteUrl,
  }) {
    return Sponsor(
      sponsorId: sponsorId ?? this.sponsorId,
      name: name ?? this.name,
      description: description ?? this.description,
      websiteUrl: websiteUrl ?? this.websiteUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sponsorId': sponsorId,
      'name': name,
      'description': description,
      'websiteUrl': websiteUrl,
    };
  }

  factory Sponsor.fromMap(Map<String, dynamic> map) {
    return Sponsor(
      sponsorId: map['sponsorId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      description: map['description'] as String? ?? '',
      websiteUrl: map['websiteUrl'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Sponsor.fromJson(String source) =>
      Sponsor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      sponsorId,
      name,
      description,
      websiteUrl,
    ];
  }
}
