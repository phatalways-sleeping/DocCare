import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specialization.g.dart';

@JsonSerializable()
final class Specialization extends Equatable {
  const Specialization({
    required this.name,
    this.description,
    required this.numMembers,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) =>
      _$SpecializationFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey()
  final String? description;
  @JsonKey(required: true)
  final int numMembers;

  @override
  List<Object?> get props => [name, description, numMembers];

  Specialization copyWith({
    String? name,
    String? description,
    int? numMembers,
  }) {
    return Specialization(
      name: name ?? this.name,
      description: description ?? this.description,
      numMembers: numMembers ?? this.numMembers,
    );
  }
}
