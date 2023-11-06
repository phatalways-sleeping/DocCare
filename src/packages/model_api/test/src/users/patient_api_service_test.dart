import 'package:flutter_test/flutter_test.dart';
import 'package:model_api/src/users/patient_api_service.dart';

void main() {
  test('Create service test', () {
    const patientService = CustomerApiService();

    expect(patientService, isNotNull);
  });
}
