// ignore_for_file: public_member_api_docs

import 'package:controllers/src/doctor/doctor_repository_service.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseDoctorRepository implements DoctorRepositoryService {
  SupabaseDoctorRepository();

  late String _doctorId;

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
  void clear() {
    _doctorId = '';
  }

  @override
  Future<Map<String, dynamic>> getProfileData() {
    // TODO: implement getProfileData
    throw UnimplementedError();
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
  }

  @override
  Future<void> addPrescriptionToDatabase({
    required String customerID,
    required String period,
    required String date,
    required String prescriptionID,
    required List<String> doctorNote,
    required Map<String, List<String>> medicines,
    required String heartRate,
    required String bloodPressure,
    required String bloodSugar,
    required String choresterol,
  }) async {
    final appointment = Appointment(
      customerID: customerID,
      doctorID: _doctorId,
      period: int.parse(period),
      date: DateTime.parse(date),
      prescriptionID: prescriptionID,
      done: false,
      note: doctorNote[1],
      diagnosis: doctorNote[0],
    );

    await _supabaseAppointmentApiService.createAppointment(appointment);

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
