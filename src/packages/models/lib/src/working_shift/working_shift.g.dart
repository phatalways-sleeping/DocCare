// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'working_shift.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkingShift _$WorkingShiftFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'doctorID',
      'startPeriodID',
      'dayOfWeek',
      'endPeriodID'
    ],
  );
  return WorkingShift(
    doctorID: json['doctorID'] as String,
    startPeriodID: json['startPeriodID'] as int,
    dayOfWeek: json['dayOfWeek'] as String,
    endPeriodID: json['endPeriodID'] as int,
  );
}

Map<String, dynamic> _$WorkingShiftToJson(WorkingShift instance) =>
    <String, dynamic>{
      'doctorID': instance.doctorID,
      'startPeriodID': instance.startPeriodID,
      'dayOfWeek': instance.dayOfWeek,
      'endPeriodID': instance.endPeriodID,
    };
