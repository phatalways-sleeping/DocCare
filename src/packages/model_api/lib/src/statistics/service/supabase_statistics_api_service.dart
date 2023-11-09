import 'package:models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:model_api/src/statistics/service/statistics_api_service.dart';

class SupabaseStatisticsApiService implements StatisticsAPIService<Statistics> {
  const SupabaseStatisticsApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

 @override
  Future<Statistics> getStatistics(int id) => supabase
      .from('statistics')
      .select<PostgrestList>()
      .eq('id', id)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No statistics with id = $id found')
            : Statistics.fromJson(value.first),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<List<Statistics>> getAllStatisticsList() => supabase
      .from('statistics')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No statistics found')
            : value.map(Statistics.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));
      
  @override
  Future<List<Statistics>> getStatisticsList(String prescriptionID) => supabase
      .from('statistics')
      .select<PostgrestList>()
      .eq('prescriptionID', prescriptionID)
      .then(
        (value) => value.isEmpty
            ? throw Exception('No statistics with prescriptionID = $prescriptionID found')
            : value.map(Statistics.fromJson).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));
  
  @override
  Future<void> createStatistics(Statistics statistics) => supabase
      .from('statistics')
      .insert(
        statistics.toJson(),
      )
      .onError((error, stackTrace) => throw Exception(error));
  
  @override
  Future<void> updateStatistics(int id, int value,  String categoryName, String prescriptionID, String note) => supabase
      .from('statistics')
      .update({
        'value': value,
        'categoryName': categoryName,
        'prescriptionID': prescriptionID,
        'note': note,
      })
      .eq('id', id)
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> deleteStatistics(int id) => supabase
      .from('statistics')
      .delete()
      .eq('id', id)
      .onError((error, stackTrace) => throw Exception(error));

  //Stream of a single statistics
  @override
  Stream<Statistics> streamStatistics(int id) => supabase
      .from('statistics')
      .stream(primaryKey: ['id'])
      .eq('id', id)
      .map((event) => Statistics.fromJson(event.first));
}