// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Specialization _$SpecializationFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['name', 'numMembers'],
  );
  return Specialization(
    name: json['name'] as String,
    description: json['description'] as String?,
    numMembers: json['numMembers'] as int,
  );
}

Map<String, dynamic> _$SpecializationToJson(Specialization instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'numMembers': instance.numMembers,
    };
