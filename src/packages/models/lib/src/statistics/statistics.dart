// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'statistics.g.dart';

@JsonSerializable()
final class Statistics extends Equatable {
  const Statistics({
    required this.id,
    required this.value,
    required this.categoryName,
    required this.prescriptionID,
    this.note,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticsToJson(this);

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String value;
  @JsonKey(required: true)
  final String categoryName;
  @JsonKey(required: true)
  final String prescriptionID;
  @JsonKey(required: false)
  final String? note;

  @override
  List<Object?> get props => [
        id,
        value,
        categoryName,
        prescriptionID,
        note,
      ];

  Statistics copyWith({
    String? id,
    String? value,
    String? categoryName,
    String? prescriptionID,
  }) {
    return Statistics(
      id: id ?? this.id,
      value: value ?? this.value,
      categoryName: categoryName ?? this.categoryName,
      prescriptionID: prescriptionID ?? this.prescriptionID,
    );
  }
}
