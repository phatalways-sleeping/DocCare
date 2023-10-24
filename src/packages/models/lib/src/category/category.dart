import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
final class Category extends Equatable {
  const Category({
    required this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey(required: false)
  final String? description;

  @override
  List<Object?> get props =>
      [name, description];

  Category copyWith({
    String? name,
    String? description,
  }) {
    return Category(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}