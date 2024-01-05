// ignore_for_file: public_member_api_docs
import 'package:controllers/src/receptionist/receptionist_repository_service.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseReceptionistRepository implements ReceptionistRepositoryService {
  SupabaseReceptionistRepository();

  late String _receptionistId;

  @override
  void initializeReceptionistId(String id) {
    _receptionistId = id;
  }

  final SupabaseReceptionistApiService _supabaseReceptionistApiService =
      SupabaseReceptionistApiService(
    supabase: Supabase.instance.client,
  );

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
      'birthday': receptionist.birthday ?? DateTime.now(),
    };
  }

  @override
  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  }) {
    // TODO: implement updateProfileData
    throw UnimplementedError();
  }
}
