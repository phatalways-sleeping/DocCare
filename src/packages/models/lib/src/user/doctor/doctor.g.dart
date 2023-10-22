// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'fullname',
      'email',
      'phone',
      'specializationId'
    ],
  );
  return Doctor(
    id: json['id'] as String,
    fullname: json['fullname'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    birthday: json['birthday'] == null
        ? null
        : DateTime.parse(json['birthday'] as String),
    specializationId: json['specializationId'] as String,
    startWorkingFrom: json['startWorkingFrom'] as int,
    rating: (json['rating'] as num?)?.toDouble(),
    numberOfRates: json['numberOfRates'] as int?,
  );
}

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'email': instance.email,
      'phone': instance.phone,
      'birthday': instance.birthday?.toIso8601String(),
      'specializationId': instance.specializationId,
      'startWorkingFrom': instance.startWorkingFrom,
      'rating': instance.rating,
      'numberOfRates': instance.numberOfRates,
    };
