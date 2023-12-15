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
      'doctorID',
      'customerID',
      'dateDone',
      'datePrescribed',
      'done',
      'diagnosis',
    ],
  );
  return Prescription(
    id: json['id'] as String,
    doctorID: json['doctorID'] as String,
    customerID: json['customerID'] as String,
    dateDone: DateTime.parse(json['dateDone'] as String),
    datePrescribed: DateTime.parse(json['datePrescribed'] as String),
    done: json['done'] as bool? ?? false,
    note: json['note'] as String? ?? '',
    diagnosis: json['diagnosis'] as String? ?? '',
  );
}

Map<String, dynamic> _$PrescriptionToJson(Prescription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doctorID': instance.doctorID,
      'customerID': instance.customerID,
      'dateDone': instance.dateDone.toIso8601String(),
      'datePrescribed': instance.datePrescribed.toIso8601String(),
      'done': instance.done,
      'note': instance.note,
      'diagnosis': instance.diagnosis,
    };
