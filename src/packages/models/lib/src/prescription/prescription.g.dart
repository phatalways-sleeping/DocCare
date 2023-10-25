// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prescription _$PrescriptionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'doctorId',
      'customerId',
      'dateDone',
      'datePrescribed',
      'done'
    ],
  );
  return Prescription(
    id: json['id'] as String,
    doctorId: json['doctorId'] as String,
    customerId: json['customerId'] as String,
    dateDone: DateTime.parse(json['dateDone'] as String),
    datePrescribed: DateTime.parse(json['datePrescribed'] as String),
    done: json['done'] as bool? ?? false,
    note: json['note'] as String? ?? '',
  );
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorId': instance.doctorId,
      'customerId': instance.customerId,
      'dateDone': instance.dateDone.toIso8601String(),
      'datePrescribed': instance.datePrescribed.toIso8601String(),
      'done': instance.done,
      'note': instance.note,
    };
