// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receptionist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receptionist _$ReceptionistFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'fullname', 'email', 'phone'],
  );
  return Receptionist(
    id: json['id'] as String,
    fullname: json['fullname'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
  );
}

Map<String, dynamic> _$ReceptionistToJson(Receptionist instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'phone': instance.phone,
      'birthday': instance.birthday?.toIso8601String(),
    };
