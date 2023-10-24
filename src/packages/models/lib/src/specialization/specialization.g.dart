// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialization _$SpecializationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'num_members'],
  );
  return Specialization(
    name: json['name'] as String,
    description: json['description'] as String?,
    num_members: json['num_members'] as int,
  );
}

Map<String, dynamic> _$SpecializationToJson(Specialization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'num_members': instance.num_members,
    };
