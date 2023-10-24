import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'specialization.g.dart';

@JsonSerializable()
final class Specialization extends Equatable {
  const Specialization({
    required this.name,
    this.description,
    required this.num_members,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) =>
      _$SpecializationFromJson(json);

  Map<String, dynamic> toJson() => _$SpecializationToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey()
  final String? description;
  @JsonKey(required: true)
  final int num_members;

  @override
  List<Object?> get props => [name, description, num_members];

  Specialization copyWith({
    String? name,
    String? description,
    int? num_members,
  }) {
    return Specialization(
      name: name ?? this.name,
      description: description ?? this.description,
      num_members: num_members ?? this.num_members,
    );
  }
}
