// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:model_api/src/medicine/medicine_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('MedicineApi', () {
    //Creat a supabase instance
    final supabase = Supabase.instance.client;

    test('Initialize', () {
      //Can be created with a supabase instance
      expect(MedicineApi(supabase: supabase), isNotNull);
    });
  });
}
