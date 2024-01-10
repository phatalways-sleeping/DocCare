import 'package:json_annotation/json_annotation.dart';

import 'package:models/src/user/base_user/base_user.dart';

part 'receptionist.g.dart';

@JsonSerializable()
final class Receptionist extends BaseUser {
  const Receptionist({
    required super.id,
    required super.fullname,
    required super.email,
    required super.phone,
    super.birthday,
  });

  factory Receptionist.fromJson(Map<String, dynamic> json) =>
      _$ReceptionistFromJson(json);

  Map<String, dynamic> toJson() => _$ReceptionistToJson(this);

  @override
  Receptionist copyWith({
    String? id,
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  }) {
    return Receptionist(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
    );
  }
}
