import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:model_api/src/prescription/service/supabase_prescription_api.dart';
import 'package:models/models.dart';

void main() {
  group('PrescriptionApi', () {
    // Create a Supabase instance
    final supabase = Supabase.instance.client;
    final prescriptionApi = PrescriptionApi(supabase: supabase);

    test('Initialize Supabase', () {
      // Can be created with a Supabase instance
      expect(PrescriptionApi(supabase: supabase), isNotNull);
    });

    test('Initialize Prescription API', () {
      // The PrescriptionApi should be created with a Supabase instance
      expect(prescriptionApi, isNotNull);
    });

    // // This test may change Database
    // test('Create and Retrieve Prescription', () async {
    //   // Sample data
    //   final id = 'P001';
    //   final done = true;
    //   final note = 'For diabetes';
    //   final doctorID = 'D001';
    //   final customerID = 'C002';
    //   final dateDone = DateTime.parse('2023-11-02 00:00:00+00');
    //   final datePrescribed = DateTime.parse('2023-11-01 00:00:00+00');

    //   // Create a prescription
    //   final prescription = Prescription(
    //     id: id,
    //     done: done,
    //     note: note,
    //     doctorID: doctorID,
    //     customerID: customerID,
    //     dateDone: dateDone,
    //     datePrescribed: datePrescribed,
    //   );

    //   // Create the prescription
    //   await prescriptionApi.createPrescription(prescription);

    //   // Retrieve the prescription by ID
    //   final retrievedPrescription =
    //       await prescriptionApi.getPrescriptionByID(id);

    //   // Verify that the retrieved prescription matches the created one
    //   expect(retrievedPrescription.id, equals(id));
    //   expect(retrievedPrescription.done, equals(done));
    //   expect(retrievedPrescription.note, equals(note));
    //   expect(retrievedPrescription.doctorID, equals(doctorID));
    //   expect(retrievedPrescription.customerID, equals(customerID));
    //   expect(retrievedPrescription.dateDone, equals(dateDone));
    // });

    // // This test may change Database
    // test('Update Prescription', () async {
    //   // Sample data for updating the prescription
    //   final id = 'P001'; // Use an existing ID for testing
    //   final updatedDone = false;
    //   final dateDone = DateTime.parse('2023-11-02 00:00:00+00');
    //   // Update the prescription
    //   await prescriptionApi.updatePrescriptionDone(
    //     id,
    //     updatedDone,
    //     dateDone,
    //   );

    //   // Retrieve the updated prescription
    //   final updatedPrescription = await prescriptionApi.getPrescriptionByID(id);

    //   // Verify that the updated prescription matches the new data
    //   expect(updatedPrescription.id, equals(id));
    //   expect(updatedPrescription.done, equals(updatedDone));
    //   expect(updatedPrescription.note, equals(dateDone));
    //   // Additional checks for other fields can be added here.
    // });

    // // This test may change Database
    // test('Delete Prescription', () async {
    //   // Sample data for deleting the prescription
    //   final id = 'P001'; // Use an existing ID for testing

    //   // Delete the prescription
    //   await prescriptionApi.deletePrescription(id);

    //   // Try to retrieve the deleted prescription by ID
    //   try {
    //     await prescriptionApi.getPrescriptionByID(id);
    //     fail('Prescription should have been deleted.');
    //   } catch (error) {
    //     // Expect an exception to be thrown as the prescription is deleted
    //     expect(error, isA<Exception>());
    //   }
    // });
  });
}
