import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthEmailApiService {
  const AuthEmailApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  // Sign up with email and password
  Future<void> signUpWithEmailPassword(String email, String password);

  // Sign in with email and password
  Future<void> signInWithEmailPassword(String email, String password);

  // Sign out
  Future<void> signOut();

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email);
}
