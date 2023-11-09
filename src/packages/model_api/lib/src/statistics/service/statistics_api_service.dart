import 'package:models/models.dart';

abstract interface class StatisticsAPIService<T extends Statistics> {
  const StatisticsAPIService();

  Future<void> createStatistics(T statistics);

  Future<void> deleteStatistics(int id);

  Future<T> getStatistics(int id);

  Future<List<Statistics>> getAllStatisticsList();

  Future<List<T>> getStatisticsList(String prescriptionID);

  Future<void> updateStatistics(int id, int value,  String categoryName, String prescriptionID, String note);

  Stream<T> streamStatistics(int id);
}