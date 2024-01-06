// ignore_for_file: public_member_api_docs

import 'dart:ffi';

import 'package:controllers/src/customer/customer_repository_service.dart';
import 'package:flutter/widgets.dart';
import 'package:models/models.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseCustomerRepository implements CustomerRepositoryService {
  SupabaseCustomerRepository();
  late String _customerId;

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

  final SupabaseAppointmentApiService _supabaseAppointmentApiService =
      SupabaseAppointmentApiService(
    supabase: Supabase.instance.client,
  );

  final SupabaseDoctorApiService _supabaseDoctorApiService =
      SupabaseDoctorApiService(
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
  Future<void> updateAppointmentDone(bool done, String prescriptionID) async {
    await Supabase.instance.client.rpc(
      'update_appointment_done',
      params: {
        'customer_id': _customerId,
        'prescription_id': prescriptionID,
        'is_done': done,
      },
    ).onError(
      (error, stackTrace) => throw Exception('Error updating done'),
    );
  }

  @override
  Future<void> updateMedicineDone(
      bool done, String prescriptionID, String medicineName) async {
    await Supabase.instance.client.rpc(
      'update_intake_done',
      params: {
        'prescription_id': prescriptionID,
        'medicine_name': medicineName,
        'is_done': done,
      },
    ).onError(
      (error, stackTrace) => throw Exception('Error updating done'),
    );
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
    ).onError((error, stackTrace) {
      return [];
    }) as List<dynamic>;

    final results = _convertMedicineData(response);

    return results;
  }

  @override
  Future<List<Map<String, dynamic>>> getCurrentPrescriptions() async {
    print(_customerId);
    final response = await Supabase.instance.client.rpc(
      'get_prescriptions',
      params: {
        'customer_id': _customerId,
        'is_done': false,
      },
    ).onError((error, stackTrace) {
      return [];
    }) as List<dynamic>;
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
        'is_done': true,
      },
    ).onError((error, stackTrace) {
      return [];
    }) as List<dynamic>;

    final results = _convertMedicineData(response);

    return results;
  }

  @override
  Future<List<Map<String, dynamic>>> getPastPrescriptions() async {
    final response = await Supabase.instance.client.rpc(
      'get_prescriptions',
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
    ).onError(
      (error, stackTrace) {
        return [];
      },
    ) as List<dynamic>;

    final medicines = _convertMedicineData(medicinesData);

    final prescription = await _supabaseAppointmentApiService
        .getAppointmentsByCustomerId(_customerId);

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

  @override
  Future<void> ratePrescription(
    int period,
    String doctorId,
    String date,
    int rating,
  ) async {
    print('Rating');
    // Prescription relation has not been added with rating yet
    // Currently, rating is in appointment table with
    // primary key is customer_id and doctor_id and date and period
    // So, we need to update rating in appointment table
    await _supabaseAppointmentApiService
        .updateRating(
          period,
          _customerId,
          doctorId,
          date,
          rating,
        )
        .onError((error, stackTrace) =>
            {print(error), debugPrint(error.toString())});
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
    required int period,
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
          'id': result['id'],
          'name': result['fullname'],
          'speciality': result['specializationId'],
          'rating': result['rating'],
          'ratingCount': result['numberOfRates'],
          'imgPath': result['photo'] ?? 'assets/images/doctor.png',
        };
      },
    ).toList();

    return results;
  }
}
