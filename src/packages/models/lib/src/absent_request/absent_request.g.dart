// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absent_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsentRequest _$AbsentRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'doctorID',
      'date',
      'doctorName',
      'dateRequest',
      'isApproved',
    ],
  );
  return AbsentRequest(
    doctorID: json['doctorID'] as String,
    date: DateTime.parse(json['date'] as String),
    doctorName: json['doctorName'] as String,
    dateRequest: DateTime.parse(json['dateRequest'] as String),
    reason: json['reason'] as String?,
    isApproved: json['isApproved'] as bool,
  );
}

Map<String, dynamic> _$AbsentRequestToJson(AbsentRequest instance) =>
    <String, dynamic>{
      'doctorID': instance.doctorID,
      'date': instance.date.toIso8601String(),
      'doctorName': instance.doctorName,
      'dateRequest': instance.dateRequest.toIso8601String(),
      'reason': instance.reason,
      'isApproved': instance.isApproved,
    };
