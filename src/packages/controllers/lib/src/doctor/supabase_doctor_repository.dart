// ignore_for_file: public_member_api_docs

import 'package:controllers/src/doctor/doctor_repository_service.dart';
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

  final SupabaseIntakeAPIService _supabaseIntakeApiService =
      SupabaseIntakeAPIService(
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
  Future<Map<String, dynamic>> getProfileData() async {
    final doctor = await _supabaseDoctorApiService.getUser(_doctorId);
    return {
      'fullName': doctor.fullname,
      'email': doctor.email,
      'phone': doctor.phone,
      'birthday': doctor.birthday,
      'specialization': doctor.specializationId,
      'startWorkingFrom': doctor.startWorkingFrom,
      'imageUrl': doctor.imageUrl,
      'rating': doctor.rating,
    };
  }

  @override
  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
    String? imageUrl,
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
            imageUrl: imageUrl ?? doctor.imageUrl,
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
    return updatedAppointment;
  }

  @override
  Future<void> addPrescriptionToDatabase({
    required String prescriptionID,
    required Map<String, dynamic> customerData,
    required List<String> doctorNote,
    required Map<String, List<String>> medicines,
    required String heartRate,
    required String bloodPressure,
    required String bloodSugar,
    required String choresterol,
  }) async {
    final customerId = customerData['customerID'] as String;
    final date = customerData['date'] as DateTime;
    final period = customerData['period'].toString();
    final customerName = customerData['customerName'] as String;

    final appointment = Appointment(
      customerID: customerId,
      doctorID: _doctorId,
      period: int.parse(period),
      date: date,
      rating:
          (customerData['rating'] == 'null' || customerData['rating'] == null)
              ? null
              : int.parse(customerData['rating'].toString()),
      customerComment: (customerData['customerComment'] == 'null' ||
              customerData['customerComment'] == null)
          ? null
          : customerData['customerComment'].toString(),
      prescriptionID: prescriptionID,
      dateDone: (customerData['dateDone'] == 'null' ||
              customerData['dateDone'] == null)
          ? null
          : DateTime.parse(customerData['dateDone'].toString()),
      done: true,
      note: doctorNote[1],
      diagnosis: doctorNote[0],
      isCanceled: false,
      customerName: customerName,
      prescriptionDone:
          customerData['prescriptionDone'] == 'true' ? true : false,
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

  @override
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
            reason: reasons,
            isApproved: false,
          ),
        )
        .timeout(
          const Duration(
            seconds: 15,
          ),
        );
  }

  @override
  List<Map<String, dynamic>> _convertMedicineData(List<dynamic> response) =>
      response.map(
        (e) {
          final result = e as Map<String, dynamic>;
          return {
            'prescription_id': result['id'],
            'medicineName': result['medicine_name'],
            'quantity': result['quantity'],
            'timeOfTheDay': result['timeOfTheDay'],
            'toBeTaken': result['toBeTaken'],
            'duration': result['duration'],
          };
        },
      ).toList();

  @override
  Future<Map<String, dynamic>> getPrescriptionData(
    String prescriptionId,
    String _customerId,
  ) async {
    final medicinesData = await Supabase.instance.client.rpc(
      'get_med_of_prescriptions',
      params: {
        'prescription_id': prescriptionId,
        'is_done': null,
      },
    ).onError(
      (error, stackTrace) {
        return [];
      },
    ) as List<dynamic>;

    final medicines = _convertMedicineData(medicinesData);

    final prescription = await _supabaseAppointmentApiService
        .getAppointmentsByCustomerId(_customerId!);

    final result = prescription.firstWhere(
      (element) => element.prescriptionID == prescriptionId,
      orElse: () => throw Exception(
        'Error from getPrescriptionData: No prescription found with id $prescriptionId',
      ),
    );

    //Get doctor name
    final doctor = await _supabaseDoctorApiService
        .getUser(result.doctorID)
        .onError((error, stackTrace) => throw Exception(error));

    //Turn result to json, replace doctorID with doctor name
    final resultJson = result.toJson();
    resultJson['doctorName'] = doctor.fullname;

    return {
      ...resultJson,
      'medicines': medicines,
    };
  }
}
