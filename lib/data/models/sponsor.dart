import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sponsor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory Sponsor.fromJson(Map<String, dynamic> json) =>
      _$SponsorFromJson(json);

  Map<String, dynamic> toJson() => _$SponsorToJson(this);

  @override
  List<Object> get props => [sponsorId, name, description, websiteUrl];
}
