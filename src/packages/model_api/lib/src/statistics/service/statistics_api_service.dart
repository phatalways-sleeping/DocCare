import 'package:models/models.dart';

abstract interface class StatisticsAPIService<T extends Statistics> {
  const StatisticsAPIService();

  Future<void> createStatistics(T statistics);

  Future<void> deleteStatistics(int id);

  Future<T> getStatistics(int id);

  Future<List<T>> getAllStatisticsList();

  Future<List<T>> getStatisticsList(String prescriptionID);

  Future<void> updateStatistics(int id, Statistics statistics);

  Future<void> updateStatisticsValue(int id, int value);

  Future<void> updateStatisticsCategoryName(int id, String categoryName);

  Future<void> updateStatisticsPrescriptionID(int id, String prescriptionID);

  Future<void> updateStatisticsNote(int id, String note);

  Stream<T> streamStatistics(int id);
}