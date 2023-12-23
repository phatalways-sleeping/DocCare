// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(
    this._customerRepositoryService,
  ) : super(
          HomeLoading.from(
            const HomeInitial.empty(),
          ),
        ) {
    on<DataLoadingEvent>(_onDataLoadingEvent);
  }

  final CustomerRepositoryService _customerRepositoryService;

  Future<void> _onDataLoadingEvent(
    DataLoadingEvent event,
    Emitter<HomeState> emit,
  ) async {
    final profileData = await _customerRepositoryService.getProfileData();
    final name = profileData['fullName'].toString();

    final prescriptionID =
        await _customerRepositoryService.getNewestPrescriptionID();

    final statisticsData =
        await _customerRepositoryService.getStatistics(prescriptionID[0]);
    final heartRate = statisticsData['heart_rate'].toString();
    final bloodPressure = statisticsData['blood_pressure'].toString();
    final cholesterol = statisticsData['cholesterol'].toString();
    final bloodSugar = statisticsData['blood_sugar'].toString();

    final oldStatisticsData =
        await _customerRepositoryService.getStatistics(prescriptionID[1]);
    final oldHeartRate = oldStatisticsData['heart_rate'].toString();
    final oldBloodPressure = oldStatisticsData['blood_pressure'].toString();
    final oldCholesterol = oldStatisticsData['cholesterol'].toString();
    final oldBloodSugar = oldStatisticsData['blood_sugar'].toString();

    final appointmentsData =
        await _customerRepositoryService.getUpcomingAppointments();

    final appointments = Map<String, List<String>>.fromEntries(
      appointmentsData.map(
        (e) => MapEntry(
          e['name'].toString(),
          [e['time'].toString()],
        ),
      ),
    );

    emit(
      HomeInitial.input(
        name: name,
        heartRate: heartRate,
        bloodPressure: bloodPressure,
        cholesterol: cholesterol,
        bloodSugar: bloodSugar,
        oldBloodPressure: oldBloodPressure,
        oldBloodSugar: oldBloodSugar,
        oldCholesterol: oldCholesterol,
        oldHeartRate: oldHeartRate,
        appointments: appointments,
      ),
    );
  }
}
