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

  final AbsentRequestAPIService _absentRequestAPIService =
      SupabaseAbsentRequestApiService(
    supabase: Supabase.instance.client,
  );

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

  @override
  Future<List<Map<String, dynamic>>> getAbsentRequests() async {
    const query = '''
*, 
doctor:doctorID ( imgPath )
''';
    final response = await Supabase.instance.client
        .from('absentRequest')
        .select<PostgrestList>(query)
        .timeout(const Duration(seconds: 15))
        .onError((error, stackTrace) => []);

    final result = response
        .map(
          (e) => {
            'name': e['doctorName'] as String,
            'dateAbsent': DateTime.parse(e['date'] as String),
            'imgPath': e['doctor']['imgPath'] ?? 'https://picsum.photos/200',
            'doctorId': e['doctorID'] as String,
            'reason': e['reason'] as String,
          },
        )
        .toList();

    return result;
  }

  @override
  Future<void> responseAbsentRequest(
    String id, {
    required DateTime date,
    required bool isAccepted,
  }) async {
    await Supabase.instance.client.rpc(
      'sp_response_absent_request',
      params: {
        'p_doctor_id': id,
        'p_date': date.toIso8601String(),
        'p_answer': isAccepted,
      },
    ).timeout(
      const Duration(seconds: 15),
    );
  }
}
