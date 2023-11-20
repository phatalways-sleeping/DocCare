/// [AuthEmailApiService] is an abstract class that provides the base for all
/// authentication services
abstract interface class AuthEmailApiService {
  /// [AuthEmailApiService] constructor
  const AuthEmailApiService();

  /// All methods should throw [Exception] 
  /// or instance extends [Exception] if there is any error

  /// [signUpWithEmailPassword] signs up with email and password
  
  Future<void> signUpWithEmailPassword(String email, String password);

  /// [signInWithEmailPassword] signs in with email and password
  Future<void> signInWithEmailPassword(String email, String password);

  /// [signOut] signs out
  Future<void> signOut();

  /// [sendPasswordResetEmail] sends password reset email
  Future<void> sendPasswordResetEmail(String email);

  /// [changePassword] changes password
  Future<void> changePassword(
    String newPassword,
  );
}
