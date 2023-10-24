// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intake _$IntakeFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['medicine_name', 'prescription_id'],
  );
  return Intake(
    medicine_name: json['medicine_name'] as String,
    prescription_id: json['prescription_id'] as String,
    duration: json['duration'] as int?,
    time_of_the_day: json['time_of_the_day'] as String?,
    to_be_taken: json['to_be_taken'] as int?,
    quantity: json['quantity'] as int?,
  );
}

Map<String, dynamic> _$IntakeToJson(Intake instance) => <String, dynamic>{
      'medicine_name': instance.medicine_name,
      'prescription_id': instance.prescription_id,
      'duration': instance.duration,
      'time_of_the_day': instance.time_of_the_day,
      'to_be_taken': instance.to_be_taken,
      'quantity': instance.quantity,
    };
