// ignore_for_file: public_member_api_docs
import 'package:controllers/src/receptionist/receptionist_repository_service.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseReceptionistRepository implements ReceptionistRepositoryService {
  SupabaseReceptionistRepository();

  final SupabaseReceptionistApiService _supabaseReceptionistApiService =
      SupabaseReceptionistApiService(
    supabase: Supabase.instance.client,
  );

  late String _receptionistId;

  @override
  void initializeReceptionistId(String id) {
    _receptionistId = id;
  }

  @override
  void clear() {
    _receptionistId = '';
  }

  @override
  Future<Map<String, dynamic>> getProfileData() async {
    final receptionist =
        await _supabaseReceptionistApiService.getUser(_receptionistId);

    return {
      'fullName': receptionist.fullname,
      'email': receptionist.email,
      'phone': receptionist.phone,
      'birthday': receptionist.birthday,
    };
  }

  @override
  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  }) async {
    final receptionist =
        await _supabaseReceptionistApiService.getUser(_receptionistId);

    await _supabaseReceptionistApiService
        .updateUser(
          _receptionistId,
          receptionist.copyWith(
            fullname: fullname ?? receptionist.fullname,
            email: email ?? receptionist.email,
            phone: phone ?? receptionist.phone,
            birthday: birthday ?? receptionist.birthday,
          ),
        )
        .onError((error, stackTrace) => throw Exception('Error updating user'));
  }

  @override
  Future<bool> isReceptionistExist(String email) async {
    final receptionist =
        await _supabaseReceptionistApiService.getAllUserEmail().catchError(
              (error) => <String>[],
            );
    return receptionist.contains(email);
  }
}
