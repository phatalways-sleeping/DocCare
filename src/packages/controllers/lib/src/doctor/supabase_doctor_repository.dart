// ignore_for_file: public_member_api_docs

import 'package:controllers/src/doctor/doctor_repository_service.dart';
import 'package:flutter/widgets.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:models/models.dart';

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

  late String _customerId;
  late String _period;
  late String _date;
  late String customerName;

  final SupabaseIntakeAPIService _supabaseIntakeApiService =
      SupabaseIntakeAPIService(
    supabase: Supabase.instance.client,
  );

  final SupabaseAppointmentApiService _supabaseAppointmentApiService =
      SupabaseAppointmentApiService(
    supabase: Supabase.instance.client,
  );

  final SupabaseStatisticsApiService _supabaseStatisticsApiService =
      SupabaseStatisticsApiService(
    supabase: Supabase.instance.client,
  );

  final SupabaseMedicineApiService _supabaseMedicineApiService =
      SupabaseMedicineApiService(
    supabase: Supabase.instance.client,
  );

  final AbsentRequestAPIService _absentRequestAPIService =
      SupabaseAbsentRequestApiService(
    supabase: Supabase.instance.client,
  );

  @override
  void initializeDoctorId(String id) {
    _doctorId = id;
  }

  @override
  void initializeDate(DateTime date) {
    _date = date.toIso8601String();
  }

  @override
  void initializeCustomerId(String id) {
    _customerId = id;
  }

  @override
  void initializeCustomerName(String name) {
    customerName = name;
  }

  @override
  String get getCustomerName => customerName;

  @override
  void initializePeriod(String period) {
    _period = period;
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
  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
  }) {
    // TODO: implement updateProfileData
    throw UnimplementedError();
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

  @override
  Future<void> addPrescriptionToDatabase({
    required String prescriptionID,
    required List<String> doctorNote,
    required Map<String, List<String>> medicines,
    required String heartRate,
    required String bloodPressure,
    required String bloodSugar,
    required String choresterol,
  }) async {
    final appointment = Appointment(
      customerID: _customerId,
      doctorID: _doctorId,
      period: int.parse(_period),
      date: DateTime.parse(_date),
      prescriptionID: prescriptionID,
      done: false,
      note: doctorNote[1],
      diagnosis: doctorNote[0],
    );

    await _supabaseAppointmentApiService.updateAppointment(appointment);

    await Future.wait([
      _supabaseStatisticsApiService.createStatistics(
        Statistics(
          id: const Uuid().v7(),
          value: heartRate,
          prescriptionID: prescriptionID,
          categoryName: 'heart_rate',
        ),
      ),
      _supabaseStatisticsApiService.createStatistics(
        Statistics(
          id: const Uuid().v7(),
          value: bloodPressure,
          prescriptionID: prescriptionID,
          categoryName: 'blood_pressure',
        ),
      ),
      _supabaseStatisticsApiService.createStatistics(
        Statistics(
          id: const Uuid().v7(),
          value: bloodSugar,
          prescriptionID: prescriptionID,
          categoryName: 'blood_sugar',
        ),
      ),
      _supabaseStatisticsApiService.createStatistics(
        Statistics(
          id: const Uuid().v7(),
          value: choresterol,
          prescriptionID: prescriptionID,
          categoryName: 'cholesterol',
        ),
      ),
    ]);

    await Future.wait([
      for (final medicine in medicines.entries)
        _supabaseIntakeApiService.createIntake(
          Intake(
            medicineName: medicine.key,
            prescriptionID: prescriptionID,
            duration: int.parse(medicine.value[0]),
            quantity: int.parse(medicine.value[1]),
            toBeTaken: (medicine.value[3] == 'Before Meal') ? 0 : 1,
            timeOfTheDay: medicine.value[2],
          ),
        ),
    ]);
  }

  @override
  Future<List<String>> getAvailableMedicine() async {
    final response = await _supabaseMedicineApiService
        .getAllMedicineList()
        .onError((error, stackTrace) => throw Exception(error));
    final result = <String>[];
    for (final medicine in response) {
      result.add(medicine.name);
    }
    return result;
  }

  Future<void> sendAbsentRequest({
    required String reasons,
    required DateTime date,
    required String doctorName,
  }) async {
    await _absentRequestAPIService
        .createAbsentRequest(
          AbsentRequest(
            doctorID: _doctorId,
            date: date,
            doctorName: doctorName,
            dateRequest: DateTime.now(),
            isApproved: false,
          ),
        )
        .timeout(
          const Duration(
            seconds: 15,
          ),
        );
  }

  
  
}