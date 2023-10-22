import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class BaseUser extends Equatable {
  const BaseUser({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    this.birthday,
  });

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String fullname;
  @JsonKey(required: true)
  final String email;
  @JsonKey(required: true)
  final String phone;
  @JsonKey()
  final DateTime? birthday;

  @override
  List<Object?> get props => [id, fullname, email, phone, birthday];

  BaseUser copyWith({
    String? id,
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  });
}
