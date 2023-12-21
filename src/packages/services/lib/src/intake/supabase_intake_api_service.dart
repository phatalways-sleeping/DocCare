// ignore_for_file: public_member_api_docs

import 'dart:ffi';

import 'package:models/models.dart';
import 'package:services/src/intake/intake_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tuple/tuple.dart';

class SupabaseIntakeAPIService implements IntakeApiService<Intake> {
  const SupabaseIntakeAPIService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<Intake> getIntake(String prescriptionID, String medicineName) =>
      supabase
          .from('intake')
          .select<PostgrestList>()
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .then(
            (value) => value.isEmpty
                ? throw Exception('No intake found')
                : Intake.fromJson(value.first),
          )
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Intake>> getAllIntakeList() => supabase
      .from('intake')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No intake found')
            : value.map(Intake.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  //get intake list, has argument is a list of prescriptionID
  @override
  Future<List<Intake>> getIntakeListByPrescriptionID(String prescriptionID) =>
      supabase
          .from('intake')
          .select<PostgrestList>()
          .eq('prescriptionID', prescriptionID)
          .then(
            (value) => value.isEmpty
                ? throw Exception('No intake found')
                : value.map(Intake.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  //get intake list, has argument is a list of prescriptionID and medicineName
  @override
  Future<List<Intake>> getIntakeList(List<Tuple2<String, String>> intakeInfo) =>
      supabase
          .from('intake')
          .select<PostgrestList>()
          .in_('prescriptionID', intakeInfo.map((e) => e.item1).toList())
          .in_('medicineName', intakeInfo.map((e) => e.item2).toList())
          .then(
            (value) => value.isEmpty
                ? throw Exception('No intake found')
                : value.map(Intake.fromJson).toList(),
          )
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createIntake(Intake intake) => supabase
      .from('intake')
      .insert(
        intake.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateIntakeDuration(
          String prescriptionID, String medicineName, Int duration) =>
      supabase
          .from('intake')
          .update({
            'duration': duration,
          })
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateIntakeTimeOfTheDay(
          String prescriptionID, String medicineName, String timeOfTheDay) =>
      supabase
          .from('intake')
          .update({
            'timeOfTheDay': timeOfTheDay,
          })
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateIntakeToBeTaken(
          String prescriptionID, String medicineName, Int toBeTaken) =>
      supabase
          .from('intake')
          .update({
            'toBeTaken': toBeTaken,
          })
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> updateIntakeQuantity(
          String prescriptionID, String medicineName, Int quantity) =>
      supabase
          .from('intake')
          .update({
            'quantity': quantity,
          })
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single intake
  @override
  Stream<Intake> streamIntake(String prescriptionID, String medicineName) =>
      supabase
          .from('intake')
          .stream(primaryKey: ['prescriptionID', 'medicineName'])
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .map((event) => Intake.fromJson(event.first));

  @override
  Future<void> deleteIntake(String prescriptionID, String medicineName) =>
      supabase
          .from('intake')
          .delete()
          .eq('prescriptionID', prescriptionID)
          .eq('medicineName', medicineName)
          .onError((error, stackTrace) => throw Exception(error));
}
