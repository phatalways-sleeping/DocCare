abstract interface class AuthEmailApiService {
  const AuthEmailApiService();

  // Sign up with email and password
  Future<void> signUpWithEmailPassword(String email, String password);

  // Sign in with email and password
  Future<void> signInWithEmailPassword(String email, String password);

  // Sign out
  Future<void> signOut();

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email);

  // Change password
  Future<void> changePassword(
    String email,
    String password,
    String newPassword,
  );
}
