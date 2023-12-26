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
    on<PageChangedEvent>(_onPageChangedEvent);
  }

  final CustomerRepositoryService _customerRepositoryService;

  void _onPageChangedEvent(
    PageChangedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        currentPage: event.page,
      ),
    );
  }

  Future<void> _onDataLoadingEvent(
    DataLoadingEvent event,
    Emitter<HomeState> emit,
  ) async {
    var oldBloodPressure = '0';
    var oldBloodSugar = '0';
    var oldCholesterol = '0';
    var oldHeartRate = '0';

    var heartRate = '0';
    var bloodPressure = '0';
    var cholesterol = '0';
    var bloodSugar = '0';

    final profileData = await _customerRepositoryService.getProfileData();
    final name = profileData['fullName'].toString();

    final prescriptionID =
        await _customerRepositoryService.getNewestPrescriptionID();

    if (prescriptionID.isNotEmpty) {
      final statisticsData =
          await _customerRepositoryService.getStatistics(prescriptionID[0]);
      heartRate = statisticsData['heart_rate'].toString();
      bloodPressure = statisticsData['blood_pressure'].toString();
      cholesterol = statisticsData['cholesterol'].toString();
      bloodSugar = statisticsData['blood_sugar'].toString();
    }

    if (prescriptionID.length > 1) {
      final oldStatisticsData =
          await _customerRepositoryService.getStatistics(prescriptionID[1]);
      oldHeartRate = oldStatisticsData['heart_rate'].toString();
      oldBloodPressure = oldStatisticsData['blood_pressure'].toString();
      oldCholesterol = oldStatisticsData['cholesterol'].toString();
      oldBloodSugar = oldStatisticsData['blood_sugar'].toString();
    }

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
        currentPage: 0,
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
