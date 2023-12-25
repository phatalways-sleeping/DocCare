// ignore_for_file: public_member_api_docs

import 'package:controllers/src/doctor/doctor_repository_service.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseDoctorRepository implements DoctorRepositoryService {
  SupabaseDoctorRepository();

  late String _doctorId;

  final SupabaseDoctorApiService _supabaseDoctorApiService =
      SupabaseDoctorApiService(
    supabase: Supabase.instance.client,
  );

  final SupabaseAppointmentApiService _supabaseAppointmentApiService =
      SupabaseAppointmentApiService(
    supabase: Supabase.instance.client,
  );


  @override
  void initializeDoctorId(String id) {
    _doctorId = id;
  }

  @override
  void clear() {
    _doctorId = '';
  }

  @override
  Future<Map<String, dynamic>> getProfileData() async {
    final doctor = await _supabaseDoctorApiService.getUser(_doctorId);
    return {
      'fullName': doctor.fullname,
      'email': doctor.email,
      'phone': doctor.phone,
      'birthday': doctor.birthday,
      'specialization': doctor.specializationId,
      'startWorkingFrom': doctor.startWorkingFrom,
    };
  }

  @override
  Future<List<dynamic>> getAppointmentsByDoctorId() async {
    final response = await _supabaseAppointmentApiService
    .getAppointmentsByDoctorId(_doctorId)
    .onError((error, stackTrace) => throw Exception(error));

    final result = <dynamic>[];
    for (final appointment in response) {
      result.add(appointment.toJson());
    }
    print(result);
    return result;
  }




  @override
  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) async {
    final doctor = await _supabaseDoctorApiService.getUser(_doctorId);
    await _supabaseDoctorApiService
        .updateUser(
          _doctorId,
          doctor.copyWith(
            fullname: fullname ?? doctor.fullname,
            email: email ?? doctor.email,
            phone: phone ?? doctor.phone,
            birthday: birthday ?? doctor.birthday,
            specializationId: specialization ?? doctor.specializationId,
            startWorkingFrom: startWorkingFrom ?? doctor.startWorkingFrom,
          ),
        )
        .onError((error, stackTrace) => throw Exception('Error updating user'));
  }

  @override
  Future<bool> isDoctorExist(String email) async {
    final doctor = await _supabaseDoctorApiService.getAllUserEmail().catchError(
          (error) => <String>[],
        );
    return doctor.contains(email);
  }
  @override
  Future<void> cancelAppointment(Appointment appointment) async {
    final updatedAppointment = await _supabaseAppointmentApiService
        .updateAppointment(appointment)
        .onError((error, stackTrace) => throw Exception(error));
  }

  
  
}