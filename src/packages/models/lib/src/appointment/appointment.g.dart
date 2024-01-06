// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'customerID',
      'doctorID',
      'period',
      'date',
      'rating',
      'customerComment',
      'prescriptionID',
      'dateDone',
      'done',
      'note',
      'diagnosis',
    ],
    requiredKeys: const [
      'customerID',
      'doctorID',
      'period',
      'date',
      'rating',
      'customerComment',
      'prescriptionID',
      'dateDone',
      'done',
      'note',
      'diagnosis',
    ],
  );
  return Appointment(
    customerID: json['customerID'] as String,
    doctorID: json['doctorID'] as String,
    period: json['period'] as int,
    date: DateTime.parse(json['date'] as String),
    rating: json['rating'] as int?,
    customerComment: json['customerComment'] as String?,
    prescriptionID: json['prescriptionID'] as String?,
    dateDone: json['dateDone'] == null
        ? null
        : DateTime.parse(json['dateDone'] as String),
    done: json['done'] as bool?,
    note: json['note'] as String?,
    diagnosis: json['diagnosis'] as String?,
    isCanceled: json['isCanceled'] as bool?,
    customerName: json['customerName'] as String?,

  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'customerID': instance.customerID,
      'doctorID': instance.doctorID,
      'period': instance.period,
      'date': instance.date.toIso8601String(),
      'rating': instance.rating,
      'customerComment': instance.customerComment,
      'prescriptionID': instance.prescriptionID,
      'dateDone': instance.dateDone?.toIso8601String(),
      'done': instance.done,
      'note': instance.note,
      'diagnosis': instance.diagnosis,
      'isCanceled': instance.isCanceled,
      'customerName': instance.customerName,

    };
