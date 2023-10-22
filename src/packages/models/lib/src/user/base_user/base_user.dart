import 'package:equatable/equatable.dart';

sealed class BaseUser extends Equatable {
  const BaseUser({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    this.birthday,
  });

  final String id;
  final String fullname;
  final String email;
  final String phone;
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
