import 'package:controllers/src/customer/customer_repository_service.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseCustomerRepository implements CustomerRepositoryService {
  SupabaseCustomerRepository();
  late String _customerId;

  String getCustomerId() {
    return _customerId;
  }

  final SupabaseCustomerApiService _supabaseCustomerApiService =
      SupabaseCustomerApiService(
    supabase: Supabase.instance.client,
  );

  final SupabasePrescriptionApiService _supabasePrescriptionApiService =
      SupabasePrescriptionApiService(
    supabase: Supabase.instance.client,
  );

  final SupabaseIntakeAPIService _supabaseIntakeApiService =
      SupabaseIntakeAPIService(
    supabase: Supabase.instance.client,
  );

  final SupabaseSpecializationApiService _supabaseSpecializationApiService =
      SupabaseSpecializationApiService(
    supabase: Supabase.instance.client,
  );

  @override
  Future<String> createCustomer(
    String fullName,
    String email,
    String phone,
    DateTime birthday,
  ) async {
    final id = const Uuid().v7();
    final customer = Customer(
      id: id,
      fullname: fullName,
      email: email,
      phone: phone,
      birthday: birthday,
    );
    await _supabaseCustomerApiService.createUser(customer);
    return id;
  }

  @override
  void initializeCustomerId(String id) {
    _customerId = id;
  }

  @override
  Future<bool> isCustomerExist(String email) async {
    final customer =
        await _supabaseCustomerApiService.getAllUserEmail().catchError(
              (error) => <String>[],
            );
    return customer.contains(email);
  }

  @override
  void clear() {
    _customerId = '';
  }

  @override
  Future<Map<String, dynamic>> getProfileData() async {
    final customer = await _supabaseCustomerApiService.getUser(_customerId);
    return {
      'fullName': customer.fullname,
      'email': customer.email,
      'phone': customer.phone,
      'birthday': customer.birthday ?? DateTime.now(),
    };
  }

  @override
  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  }) async {
    final customer = await _supabaseCustomerApiService.getUser(_customerId);
    await _supabaseCustomerApiService
        .updateUser(
          _customerId,
          customer.copyWith(
            fullname: fullname ?? customer.fullname,
            email: email ?? customer.email,
            phone: phone ?? customer.phone,
            birthday: birthday ?? customer.birthday,
          ),
        )
        .onError((error, stackTrace) => throw Exception('Error updating user'));
  }

  @override
  Future<List<Map<String, dynamic>>> getCurrentPrescriptionMedicines(
    String prescriptionId,
  ) async {
    final response = await Supabase.instance.client.rpc(
      'get_med_of_prescriptions',
      params: {
        'prescription_id': prescriptionId,
        'is_done': false,
      },
    ).onError((error, stackTrace) => []) as List<dynamic>;

    final results = _convertMedicineData(response);

    return results;
  }

  @override
  Future<List<Map<String, dynamic>>> getCurrentPrescriptions() async {
    final response = await Supabase.instance.client.rpc(
      'get_cur_prescriptions',
      params: {
        'customer_id': _customerId,
        'is_done': false,
      },
    ).onError((error, stackTrace) => []) as List<dynamic>;
    final results = response.map(
      (e) {
        final result = e as Map<String, dynamic>;
        return {
          'doctorName': result['doctorname'],
          'date': result['date'],
          'id': result['id'],
          'note': result['note'],
        };
      },
    ).toList();
    return results;
  }

  @override
  Future<List<Map<String, dynamic>>> getPastPrescriptionMedicines(
    String prescriptionId,
  ) async {
    final response = await Supabase.instance.client.rpc(
      'get_med_of_prescriptions',
      params: {
        'prescription_id': prescriptionId,
        'is_done': false,
      },
    ).onError((error, stackTrace) => []) as List<dynamic>;

    final results = _convertMedicineData(response);

    return results;
  }

  @override
  Future<List<Map<String, dynamic>>> getPastPrescriptions() async {
    final response = await Supabase.instance.client.rpc(
      'get_cur_prescriptions',
      params: {
        'customer_id': _customerId,
        'is_done': true,
      },
    ).onError((error, stackTrace) => []) as List<dynamic>;
    final results = response.map(
      (e) {
        final result = e as Map<String, dynamic>;
        return {
          'doctorName': result['doctorname'],
          'date': result['date'],
          'id': result['id'],
          'note': result['note'],
        };
      },
    ).toList();
    return results;
  }

  @override
  Future<Map<String, dynamic>> getPrescriptionData(
    String prescriptionId,
  ) async {
    final medicinesData = await Supabase.instance.client.rpc(
      'get_med_of_prescriptions',
      params: {
        'prescription_id': prescriptionId,
        'is_done': null,
      },
    ).onError((error, stackTrace) => []) as List<dynamic>;

    final medicines = _convertMedicineData(medicinesData);

    final prescription = await _supabasePrescriptionApiService
        .getPrescriptionByID(prescriptionId);

    return {
      ...prescription.toJson(),
      'medicines': medicines,
    };
  }

  @override
  Future<void> ratePrescription(String prescriptionId, int rating) async {
    // Prescription relation has not been added with rating yet
    // Currently, rating is in appointment table with
    // primary key is customer_id and doctor_id and date and period
    // So, we need to update rating in appointment table
    await _supabasePrescriptionApiService
        .updatePrescriptionRating(
          prescriptionId,
          rating,
        )
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

  @override
  Future<void> toggleMedicine(
    String medicine,
    String prescriptionId, {
    required bool isDone,
  }) async {
    await _supabaseIntakeApiService
        .updateIntakeDone(
          medicine,
          prescriptionId,
          done: isDone,
        )
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

  @override
  Future<void> togglePrescription(
    String prescriptionId, {
    required bool isDone,
  }) async {
    await _supabasePrescriptionApiService
        .updatePrescriptionDone(
          prescriptionId,
          isDone,
          DateTime.now(),
        )
        .onError((error, stackTrace) => debugPrint(error.toString()));
  }

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
  Future<List<Map<String, dynamic>>> getAvailableDoctors({
    List<String>? specialities,
    int? rating,
    String? searchName,
    DateTime? date,
  }) async {
    final response = await Supabase.instance.client.rpc(
      'get_doctor_with_filter',
      params: {
        'signal': specialities != null ? 0 : 1,
        'arr_speciality': specialities,
        'filterratings': rating ?? -1,
        'searchname': searchName,
      },
    ) as List<dynamic>;

    final results = response.map(
      (e) {
        final result = e as Map<String, dynamic>;
        return {
          'id': result['doctorid'],
          'name': result['name'],
          'speciality': result['speciality'],
          'rating': result['ratings'],
          'ratingCount': result['ratingcount'],
          'imgPath': result['imgPath'] ?? 'assets/images/doctor.png',
        };
      },
    ).toList();

    return results.take(10).toList();
  }

  @override
  Future<List<String>> getDoctorSpecialization() async =>
      _supabaseSpecializationApiService.getAllSpecialization();

  @override
  Future<List<Map<String, dynamic>>> getAvailablePeriod(
    String doctorId,
    DateTime date,
    String customerid,
  ) async {
    final response = await Supabase.instance.client.rpc(
      'get_doctor_available_day2',
      params: {
        'p_doctorid': doctorId,
        'p_date': date.toIso8601String(), // Convert DateTime to ISO8601 string
        'p_customerid': customerid,
      },
    ) as List<dynamic>;

    final results = response.map(
      (e) {
        final result = e as Map<String, dynamic>;
        return {
          'period_id': result['period_id'],
          'time':
              result['time'], // Update to match the column name in the function
        };
      },
    ).toList();

    return results;
  }

  @override
  Future<List<Map<String, dynamic>>> getAvailablePeriodWithSpecialization({
    required String specialization,
    required DateTime date,
    required String customerid,
  }) async {
    final response = await Supabase.instance.client
        .rpc('get_doctor_with_specialization_available_periods2', params: {
      'p_specialization': specialization,
      'p_date': date.toIso8601String(), // Convert DateTime to ISO8601 string
      'p_customerid': customerid,
    }) as List<dynamic>;

    final results = response.map(
      (e) {
        final result = e as Map<String, dynamic>;
        return {
          'period_id': result['period_id'],
          'time':
              result['time'], // Update to match the column name in the function
        };
      },
    ).toList();
    return results;
  }

  @override
  Future<void> bookAppointmentWithDoctor({
    required int period,
    required String customerid,
    required String doctorid,
    required DateTime date,
    required String customername,
    String? customerComment,
  }) async {
    await Supabase.instance.client.rpc(
      'add_appointment_with_doctor_record2',
      params: {
        'p_period': period,
        'p_customerid': customerid,
        'p_doctorid': doctorid,
        'p_date': date.toIso8601String(),
        'p_customer_comment': customerComment,
        'p_prescriptionid': null,
        'p_datedone': null,
        'p_done': null,
        'p_note': null,
        'p_diagnosis': null,
        'p_rating': null,
        'p_iscanceled': false,
        'p_customername': customername,
      },
    ).onError(
      (error, stackTrace) => debugPrint(
        error.toString(),
      ),
    );
  }

  @override
  Future<void> bookAppointmentWithoutDoctor({
    required int period,
    required String customerid,
    required DateTime date,
    required String specialization,
    required String customername,
    String? customerComment,
  }) async {
    await Supabase.instance.client.rpc(
      'book_appointment_without_doctor_selection',
      params: {
        'p_specialization': specialization,
        'p_periodid': period,
        'p_customerid': customerid,
        'p_date': date.toIso8601String(),
        'p_customer_comment': customerComment,
        'p_prescriptionid': null,
        'p_datedone': null,
        'p_done': null,
        'p_note': null,
        'p_diagnosis': null,
        'p_rating': null,
        'p_iscanceled': false,
        'p_customername': customername,
      },
    ).onError(
      (error, stackTrace) => debugPrint(
        error.toString(),
      ),
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getDoctorWorkingShift({
    required String doctorid,
  }) async {
    final response = await Supabase.instance.client.rpc(
      'get_doctor_working_days',
      params: {
        'doctor_id': doctorid,
      },
    ) as List<dynamic>;

    final results = response.map(
      (e) {
        final result = e as Map<String, dynamic>;
        return {
          'date':
              result['date'], // Update to match the column name in the function
        };
      },
    ).toList();

    return results;
  }

  @override
  Future<bool> checkExistingAppointment({
    required int period,
    required String doctorid,
    required DateTime date,
  }) async {
    final checkExisting = await Supabase.instance.client.rpc(
      'check_appointment_existing',
      params: {
        'p_periodid': period,
        'p_doctorid': doctorid,
        'p_date':
            date.toIso8601String(), // Ensure date is converted to a string
      },
    ) as int;

    // Check if the stored procedure returned 1 (true) or 0 (false)
    return checkExisting == 1;
  }

  @override
  Future<String> getHighestRatingDoctor({
    required String speciality,
    required DateTime date,
    required int period,
  }) async {
    final doctorID = await Supabase.instance.client.rpc(
      'get_highest_rating_doctor',
      params: {
        'p_specialization': speciality,
        'p_date': date.toIso8601String(),
        'p_periodid': period,
      },
    ) as String;

    return doctorID;
  }
}
