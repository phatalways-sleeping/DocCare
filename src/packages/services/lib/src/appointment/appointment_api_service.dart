// ignore_for_file: public_member_api_docs

abstract interface class AppointmentApiService<Appointment> {
  const AppointmentApiService();

  Future<void> createAppointment(Appointment appointment);

  Future<void> deleteAppointmentByDoctorId(String doctorId);

  Future<void> deleteAppointmentByCustomerId(String customerId);

  Future<List<Appointment>> getAppointmentsByDoctorId(String doctorId);

  Future<List<Appointment>> getAppointmentsByCustomerId(String customerId);

  Future<List<Appointment>> getAppointmentsByDate(DateTime date);

  Future<void> updateAppointment(Appointment appointment);

  Future<void> updateRating(
    String customerId,
    int rating,
  );

  Future<void> updateCustomerComment(String customerId, String customerComment);
}