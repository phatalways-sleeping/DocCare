// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Statistics _$StatisticsFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'value', 'categoryName', 'prescriptionID'],
  );
  return Statistics(
    id: json['id'] as String,
    value: json['value'] as String,
    categoryName: json['categoryName'] as String,
    prescriptionID: json['prescriptionID'] as String,
    note: json['note'] as String?,
  );
}

Map<String, dynamic> _$StatisticsToJson(Statistics instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'categoryName': instance.categoryName,
      'prescriptionID': instance.prescriptionID,
      'note': instance.note,
    };
