import 'package:model_api/src/users//service/user_api_service.dart';
import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementation of [UserApiService] for [Customer]
class CustomerApiService implements UserApiService<Customer> {
  /// Default constructor
  const CustomerApiService({
    required this.supabase,
  });

  /// Supabase client for accessing database
  final SupabaseClient supabase;

  @override
  Future<Customer> getUser(String id) => supabase
      .from('customer')
      .select<PostgrestList>()
      .eq('id', id)
      .limit(1)
      .then(
        (value) => value.isEmpty
            ? throw Exception('Error from getUser: No user found with id $id')
            : Customer.fromJson(value.first),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<List<Customer>> getUsers(List<String> ids) => supabase
      .from('customer')
      .select<PostgrestList>()
      .in_('id', ids)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getUsers: No users found with ids $ids',
              )
            : value.map(Customer.fromJson).toList(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Stream<Customer> streamUser(String id) =>
      supabase.from('customer').stream(primaryKey: ['id']).eq('id', id).map(
            (event) => Customer.fromJson(
              event.first,
            ),
          );

  @override
  Future<void> updateBirthday(String id, DateTime birthday) => supabase
      .from('customer')
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
      .from('customer')
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
      .from('customer')
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
      .from('customer')
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
  Future<void> updateUser(String id, Customer user) => supabase
      .from('customer')
      .update(
        user.toJson(),
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );
}
