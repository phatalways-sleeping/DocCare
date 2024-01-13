// ignore_for_file: deprecated_member_use

import 'package:postgres/postgres.dart';

Future<void> callBookingWithDoc1() async {
  final connection = await Connection.open(
    Endpoint(
      host: 'db.bdxhcbmciknwrjjyqvzi.supabase.co',
      database: 'postgres',
      username: 'postgres',
      password: 'Trankimphat147258369',
    ),
  );

  // await connection.open();

  try {
    await connection.execute(
      'BEGIN; SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; '
      'SELECT booking_with_doc1('
      ':p_period, :p_customerid, :p_doctorid, :p_date, :p_rating, '
      ':p_customer_comment, :p_prescriptionid, :p_datedone, :p_done, '
      ':p_note, :p_diagnosis, :p_isCanceled, :p_customerName); COMMIT;',
      parameters: {
        'p_period': 12, // Replace with your actual values
        'p_customerid': '',
        'p_doctorid': 'doctor_id',
        'p_date': DateTime.now(),
        'p_rating': 5,
        'p_customer_comment': 'customer_comment',
        'p_prescriptionid': 'prescription_id',
        'p_datedone': DateTime.now(),
        'p_done': true,
        'p_note': 'some_note',
        'p_diagnosis': 'some_diagnosis',
        'p_isCanceled': false,
        'p_customerName': 'customer_name',
      },
    );
  } finally {
    await connection.close();
  }
}

void main() async {
  await callBookingWithDoc1();
}
