// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

const fetchPeriodic = Duration(seconds: 10);

extension _HomeBlocX on HomeBloc {
  Stream<Map<String, List<String>>> get _fetchDataPeriodicStream async* {
    while (true) {
      // debugPrint('Fetching data...');
      final response =
          await _customerRepositoryService.getUpcomingAppointments();
      final appointments = Map<String, List<String>>.fromEntries(
        response.map(
          (e) => MapEntry(
            e['name'].toString(),
            [
              e['time'].toString(),
              e['appointment_date'].toString(),
              e['doctor_name'].toString(),
            ],
          ),
        ),
      );
      yield appointments;
      await Future.delayed(fetchPeriodic, () {}); // delay for 5 seconds
    }
  }
}

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
    on<FetchNotificationsPeriodicEvent>(
      (event, emit) async => emit.forEach(
        _fetchDataPeriodicStream,
        onData: (data) {
          return state.copyWith(
            appointments: data,
          );
        },
      ),
    );
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
    var oldBloodPressure = 'N/A';
    var oldBloodSugar = 'N/A';
    var oldCholesterol = 'N/A';
    var oldHeartRate = 'N/A';

    var heartRate = 'N/A';
    var bloodPressure = 'N/A';
    var cholesterol = 'N/A';
    var bloodSugar = 'N/A';

    final profileData = await _customerRepositoryService.getProfileData();
    final name = profileData['fullName'].toString();

    final prescriptionID =
        await _customerRepositoryService.getNewestPrescriptionID();

    if (prescriptionID.isNotEmpty && prescriptionID[0] != 'null') {
      final statisticsData =
          await _customerRepositoryService.getStatistics(prescriptionID[0]);
      heartRate = statisticsData['heart_rate'].toString();
      bloodPressure = statisticsData['blood_pressure'].toString();
      cholesterol = statisticsData['cholesterol'].toString();
      bloodSugar = statisticsData['blood_sugar'].toString();
    }

    if (prescriptionID.length > 1 && prescriptionID[1] != 'null') {
      final oldStatisticsData =
          await _customerRepositoryService.getStatistics(prescriptionID[1]);
      oldHeartRate = oldStatisticsData['heart_rate'].toString();
      oldBloodPressure = oldStatisticsData['blood_pressure'].toString();
      oldCholesterol = oldStatisticsData['cholesterol'].toString();
      oldBloodSugar = oldStatisticsData['blood_sugar'].toString();
    }

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
        appointments: const {},
      ),
    );

    // Trigger periodic fetch
    add(const FetchNotificationsPeriodicEvent());
  }
}
