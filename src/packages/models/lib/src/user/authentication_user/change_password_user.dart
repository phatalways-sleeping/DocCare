import 'package:equatable/equatable.dart';
import 'package:models/src/user/authentication_user/authentication_user_service.dart';

/// [ChangePasswordUser] is the user for change password
final class ChangePasswordUser extends Equatable
    implements ChangePasswordUserService {
  /// Constructor
  const ChangePasswordUser(
    this._newPassword,
  );

  final String _newPassword;

  @override
  String get newPassword => _newPassword;

  @override
  List<Object?> get props => [newPassword];

  /// [copyWith] copies the current instance of [ChangePasswordUser]
  ChangePasswordUser copyWith({
    String? newPassword,
  }) {
    return ChangePasswordUser(
      newPassword ?? this.newPassword,
    );
  }
}
