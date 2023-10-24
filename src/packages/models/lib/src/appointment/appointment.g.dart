// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'customer_id',
      'doctor_id',
      'period',
      'date',
      'customer_comment'
    ],
  );
  return Appointment(
    customer_id: json['customer_id'] as String,
    doctor_id: json['doctor_id'] as String,
    period: json['period'] as int,
    date: DateTime.parse(json['date'] as String),
    rating: json['rating'] as int?,
    customer_comment: json['customer_comment'] as String,
  );
}

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'customer_id': instance.customer_id,
      'doctor_id': instance.doctor_id,
      'period': instance.period,
      'date': instance.date.toIso8601String(),
      'rating': instance.rating,
      'customer_comment': instance.customer_comment,
    };
