import 'package:models/models.dart';
import 'package:services/src/users/medical_staff_api_service.dart';
import 'package:services/src/users/user_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementation of [UserApiService] for [Doctor] with Supabase
class SupabaseDoctorApiService
    implements MedicalStaffApiService, UserApiService {
  /// Default constructor
  const SupabaseDoctorApiService({
    required this.supabase,
  });

  /// Supabase client for accessing database
  final SupabaseClient supabase;

  @override
  Future<List<String>> getAllUserEmail() => supabase
      .from('doctor')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No doctor email found')
            : value.map((item) => item['email'] as String).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createUser(BaseUser user) => supabase
      .from('doctor')
      .insert(
        (user as Doctor).toJson(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> deleteUser(String id) =>
      supabase.from('doctor').delete().eq('id', id).onError(
            (error, stackTrace) => throw Exception(error),
          );

  @override
  Future<Doctor> getUser(String id) => supabase
      .from('doctor')
      .select<PostgrestList>()
      .eq('id', id)
      .limit(1)
      .then(
        (value) => value.isEmpty
            ? throw Exception('Error from getUser: No user found with id $id')
            : Doctor.fromJson(value.first),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<List<Doctor>> getUsers(List<String> ids) => supabase
      .from('doctor')
      .select<PostgrestList>()
      .in_('id', ids)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getUsers: No users found with ids $ids',
              )
            : value.map(Doctor.fromJson).toList(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Stream<Doctor> streamUser(String id) =>
      supabase.from('doctor').stream(primaryKey: ['id']).eq('id', id).map(
            (event) => Doctor.fromJson(event.first),
          );

  @override
  Future<void> updateBirthday(String id, DateTime birthday) => supabase
      .from('doctor')
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
      .from('doctor')
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
      .from('doctor')
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
      .from('doctor')
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
      .from('doctor')
      .update(
        (user as Doctor).toJson(),
      )
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateNumberOfRates(String id, int numberOfRates) => supabase
      .from('doctor')
      .update({
        'numberOfRates': numberOfRates,
      })
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateRating(String id, double rating) => supabase
      .from('doctor')
      .update({
        'rating': rating,
      })
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateSpecialty(String id, String specializationId) => supabase
      .from('doctor')
      .update({
        'specializationId': specializationId,
      })
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateStartWorkingFrom(String id, int startWorkingFrom) =>
      supabase
          .from('doctor')
          .update({
            'startWorkingFrom': startWorkingFrom,
          })
          .eq('id', id)
          .onError(
            (error, stackTrace) => throw Exception(error),
          );

  @override
  Future<void> updateImageUrl(String id, String? imageUrl) => supabase
      .from('doctor')
      .update({
        'imageUrl': imageUrl,
      })
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateIsDisable(String id, bool isDisable) => supabase
      .from('doctor')
      .update({
        'isDisable': isDisable,
      })
      .eq('id', id)
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<String> getDoctorIdByEmail(String email) => supabase
      .from('doctor')
      .select<PostgrestList>()
      .eq('email', email)
      .limit(1)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getDoctorIdByEmail: No doctor found with email $email')
            : value.first['id'] as String,
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );
}
