import 'package:supabase_flutter/supabase_flutter.dart';

class AuthApi {
  const AuthApi({
    required this.supabase,
  });

  final SupabaseClient supabase;

  // Sign up with email and password
  Future<void> signUpWithEmailPassword(String email, String password) async {
    await supabase.auth.signUp(email: email, password: password);
  }

  // Sign in with email and password
  Future<void> signInWithEmailPassword(String email, String password) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
  }

  // Sign out
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }
}
