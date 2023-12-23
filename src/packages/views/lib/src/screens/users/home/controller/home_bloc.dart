// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeLoading.from(
            const HomeInitial.empty(),
          ),
        ) {
    on<DataLoadingEvent>(_onDataLoadingEvent);
  }

  Future<void> _onDataLoadingEvent(
    DataLoadingEvent event,
    Emitter<HomeState> emit,
  ) async {
    // TODO(phucchuhoang): Replace with real data from API
    print('Loading data...');
    const bloodPressure = '120/80';
    const cholesterol = '5.2';
    const bloodSugar = '5.2';
    const heartRate = '80';
    const name = 'Orz Orz Orz';
    final appointments = {
      'Cardiology Consultation': ['10:00 AM'],
      'Dental Consultation': ['11:00 AM'],
      'Eye Consultation': ['12:00 PM'],
    };
    const oldBloodPressure = '120/80';
    const oldCholesterol = '5.2';
    const oldBloodSugar = '5.2';
    const oldHeartRate = '80';

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
