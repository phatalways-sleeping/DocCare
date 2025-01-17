import 'package:models/models.dart';
import 'package:services/src/users/user_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementation of [UserApiService] for [Receptionist] with Supabase
class SupabaseReceptionistApiService implements UserApiService {
  /// Default constructor
  const SupabaseReceptionistApiService({
    required this.supabase,
  });

  /// Supabase client for accessing database
  final SupabaseClient supabase;

  @override
  Future<List<String>> getAllUserEmail() => supabase
      .from('receptionist')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No receptionist email found')
            : value.map((item) => item['email'] as String).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createUser(BaseUser user) => supabase
      .from('receptionist')
      .insert(
        (user as Receptionist).toJson(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> deleteUser(String id) =>
      supabase.from('receptionist').delete().eq('id', id).onError(
            (error, stackTrace) => throw Exception(error),
          );

  @override
  Future<Receptionist> getUser(String id) => supabase
      .from('receptionist')
      .select<PostgrestList>()
      .eq('id', id)
      .limit(1)
      .then(
        (value) => value.isEmpty
            ? throw Exception('Error from getUser: No user found with id $id')
            : Receptionist.fromJson(value.first),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<List<Receptionist>> getUsers(List<String> ids) => supabase
      .from('receptionist')
      .select<PostgrestList>()
      .in_('id', ids)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getUsers: No users found with ids $ids',
              )
            : value.map(Receptionist.fromJson).toList(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Stream<Receptionist> streamUser(String id) =>
      supabase.from('receptionist').stream(primaryKey: ['id']).eq('id', id).map(
            (event) => Receptionist.fromJson(
              event.first,
            ),
          );

  @override
  Future<void> updateBirthday(String id, DateTime birthday) => supabase
      .from('receptionist')
      .update(
        {
          'birthday': birthday.toIso8601String(),
        },
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateEmail(String id, String email) => supabase
      .from('receptionist')
      .update(
        {
          'email': email,
        },
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateFullName(String id, String fullname) => supabase
      .from('receptionist')
      .update(
        {
          'fullname': fullname,
        },
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updatePhone(String id, String phone) => supabase
      .from('receptionist')
      .update(
        {
          'phone': phone,
        },
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateUser(String id, BaseUser user) => supabase
      .from('receptionist')
      .update(
        (user as Receptionist).toJson(),
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );
}
