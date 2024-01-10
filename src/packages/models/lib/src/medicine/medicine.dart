import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medicine.g.dart';

@JsonSerializable()
final class Medicine extends Equatable {
  const Medicine({
    required this.name,
    required this.unit,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineToJson(this);

  @JsonKey(required: true)
  final String name;
  @JsonKey(required: true)
  final String unit;

  @override
  List<Object?> get props => [this.name, this.unit];

  Medicine copyWith({
    String? name,
    String? unit,
  }) {
    return Medicine(
      name: name ?? this.name,
      unit: unit ?? this.unit,
    );
  }
}
