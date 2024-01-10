import 'package:json_annotation/json_annotation.dart';

import 'package:models/src/user/base_user/base_user.dart';

part 'customer.g.dart';

@JsonSerializable()
final class Customer extends BaseUser {
  const Customer({
    required super.id,
    required super.fullname,
    required super.email,
    required super.phone,
    super.birthday,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);

  @override
  Customer copyWith({
    String? id,
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  }) {
    return Customer(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
    );
  }
}
