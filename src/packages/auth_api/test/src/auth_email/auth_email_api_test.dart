import 'package:auth_api/src/auth_email/service/supabase_auth_email_api_service.dart';
import 'package:env_flutter/env_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('AuthApi Tests', () {
    late SupabaseClient supabase;
    late SupabaseAuthEmailApiService authApi;
    setUp(() async {
      await dotenv.load();
      String supabaseUrl = dotenv.get('SUPABASE_URL');
      String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');
      // Initialize SupabaseClient for testing (replace with actual configurations)
      supabase = SupabaseClient(supabaseUrl, supabaseAnonKey);
      authApi = SupabaseAuthEmailApiService(supabase: supabase);
    });

    test('Sign up with email and password', () async {
      final email = 'test@example.com';
      final password = 'testPassword';

      await authApi.signUpWithEmailPassword(email, password);

      // You can add assertions here to check the result or verify side effects
    });

    test('Sign in with email and password', () async {
      final email = 'test@example.com';
      final password = 'testPassword';

      await authApi.signInWithEmailPassword(email, password);

      // You can add assertions here to check the result or verify side effects
    });

    test('Sign out', () async {
      await authApi.signOut();

      // You can add assertions here to check the result or verify side effects
    });

    test('Send password reset email', () async {
      final email = 'test@example.com';

      await authApi.sendPasswordResetEmail(email);

      // You can add assertions here to check the result or verify side effects
    });
  });
}
