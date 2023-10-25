// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Intake _$IntakeFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['medicineName', 'prescriptionID'],
  );
  return Intake(
    medicineName: json['medicineName'] as String,
    prescriptionID: json['prescriptionID'] as String,
    duration: json['duration'] as int?,
    timeOfTheDay: json['timeOfTheDay'] as String?,
    toBeTaken: json['toBeTaken'] as int?,
    quantity: json['quantity'] as int?,
  );
}

Map<String, dynamic> _$IntakeToJson(Intake instance) => <String, dynamic>{
      'medicineName': instance.medicineName,
      'prescriptionID': instance.prescriptionID,
      'duration': instance.duration,
      'timeOfTheDay': instance.timeOfTheDay,
      'toBeTaken': instance.toBeTaken,
      'quantity': instance.quantity,
    };
