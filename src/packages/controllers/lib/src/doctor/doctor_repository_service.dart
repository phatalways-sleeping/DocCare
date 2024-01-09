// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';

abstract interface class DoctorRepositoryService {
  void initializeDoctorId(String id);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<bool> isDoctorExist(String email);

  Future<List<dynamic>> getAppointmentsByDoctorId();

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? specialization,
    int? startWorkingFrom,
    String? imageUrl,
  });
  Future<void> cancelAppointment(Appointment appointment);

  Future<void> addPrescriptionToDatabase({
    required String prescriptionID,
    required Map<String, dynamic> customerData,
    required List<String> doctorNote,
    required Map<String, List<String>> medicines,
    required String heartRate,
    required String bloodPressure,
    required String bloodSugar,
    required String choresterol,
  });

  Future<List<String>> getAvailableMedicine();

  Future<void> sendAbsentRequest({
    required String reasons,
    required DateTime date,
    required String doctorName,
  });
  List<Map<String, dynamic>> _convertMedicineData(List<dynamic> response);
  Future<Map<String, dynamic>> getPrescriptionData(
    String prescriptionId,
    String _customerId,
  );
}
