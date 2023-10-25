// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['customerID', 'doctorID', 'period', 'date'],
  );
  return Appointment(
    customerID: json['customerID'] as String,
    doctorID: json['doctorID'] as String,
    period: json['period'] as int,
    date: DateTime.parse(json['date'] as String),
    rating: json['rating'] as int?,
    customerComment: json['customerComment'] as String?,
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
    };
