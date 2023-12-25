import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:controllers/controllers.dart';
import 'package:models/models.dart';
import 'dart:async';
import 'package:utility/utility.dart';

part 'doctor_home_event.dart';
part 'doctor_home_state.dart';

class DoctorHomeBloc extends Bloc<DoctorHomeEvent, DoctorHomeState> {
  DoctorHomeBloc(
    this._navigatorKey,
    this._notificationManagerService,
    this._doctorRepositoryService,
  ) : super(DoctorHomeInitial.empty()) {
    on<DoctorHomeLoadEvent>(_onDoctorHomeLoadEvent);
    on<DoctorHomeOpenDoctorScheduleViewEvent>(
        _onDoctorHomeOpenDoctorScheduleViewEvent);
    on<DoctorHomeResetEvent>(_onDoctorHomeResetEvent);
    on<DoctorHomeOpenCancelAppointmentViewEvent>(
        _onDoctorHomeOpenCancelAppointmentViewEvent);
  }
  final DoctorRepositoryService? _doctorRepositoryService;
  //final AuthenticationRepositoryService authenticationRepositoryService;
  final GlobalKey<NavigatorState> _navigatorKey;
  final NotificationManagerService _notificationManagerService;

  void _onDoctorHomeLoadEvent(
    DoctorHomeLoadEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
    try {
      // remove this 2 lines when login is done and doctor id is passed from login screen
      final id = 'D001';
      _doctorRepositoryService!.initializeDoctorId(id);
      final List<dynamic> appointments =
          await _doctorRepositoryService!.getAppointmentsByDoctorId();
      final dynamic profileData =
          await _doctorRepositoryService!.getProfileData();
      final String doctorName = profileData['fullName'];
      // get doctor name after changing the doctor table in the database
      // final String doctorAvatarUrl = profileData['imgPath'];
      // just hard code for now
      final String doctorAvatarUrl =
          'https://pics.craiyon.com/2023-07-05/a8e9e1290f08447bb300681ce2b563e9.webp';
      int upcomingAppointmentIndex = -1;
      String upcomingCustomerName = '';
      //final DateTime DateTimeNow = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0);
      Map<String, List<dynamic>> appointmentMap = {};
      // get the index of the upcoming appointment, which is after current time and closest to current time
      // also map the appointments to each date
      for (int i = 0; i < appointments.length; i++) {
        if (appointments[i]['isCanceled'] == true) continue;
        DateTime tmp = DateTime.parse(appointments[i]['date']);
        //tmp = DateTime(tmp.year, tmp.month, tmp.day, 0, 0, 0);
        int hour = (appointments[i]['period'].toInt() / 2).toInt() + 7;
        int minute = (appointments[i]['period'].toInt() % 2) * 30;
        DateTime exactTime =
            DateTime(tmp.year, tmp.month, tmp.day, hour, minute, 0);
            
        if (exactTime.isAfter(DateTime.now()) ||
            exactTime.isAtSameMomentAs(DateTime.now())) {
          if (upcomingAppointmentIndex == -1 ||
              tmp.isBefore(DateTime.parse(
                  appointments[upcomingAppointmentIndex]['date'])) ||
              (tmp.isAtSameMomentAs(DateTime.parse(
                      appointments[upcomingAppointmentIndex]['date'])) &&
                  appointments[i]['period'] <
                      appointments[upcomingAppointmentIndex]['period'])) {
            upcomingAppointmentIndex = i;
          }
        }
        String convertedDate = tmp.year.toString() +
            '-' +
            tmp.month.toString() +
            '-' +
            tmp.day.toString();
        // Check if the key exists in the appointmentMap
        if (appointmentMap.containsKey(convertedDate)) {
          // If the key exists, add the appointment to the existing list
          appointmentMap[convertedDate]!.add(appointments[i]);
        } else {
          // If the key doesn't exist, create a new list with the appointment and assign it to the key
          appointmentMap[convertedDate] = [appointments[i]];
        }
      }
      // get the customer name of the upcoming appointment
      if (upcomingAppointmentIndex != -1) {
        // GET THE CUSTOMER NAME AFTER CHANGING THE APPOINTMENT TABLE IN THE DATABASE
        upcomingCustomerName =
            appointments[upcomingAppointmentIndex]['customerName'];
      } else
        upcomingCustomerName = 'no appointment';
      // this is for debuging later:

      // print("this is for debug in doctor home bloc");
      // print(appointments.toString());
      // print(doctorName);
      // print(doctorAvatarUrl);
      // print(DateTime.parse(appointments[0]['date']));
      // print(DateTime.parse(appointments[0]['date']).runtimeType);
      // print('appointments');
      // print(appointments);
      // print('appointmentMap');
      // print(appointmentMap);
      // print('upcomingCustomerName');
      // print(upcomingCustomerName);
      // print('upcomingAppointmentIndex');
      // print(upcomingAppointmentIndex);

      emit(
        DoctorHomeLoadedSuccess(
          doctorName: doctorName,
          doctorAvatarUrl: doctorAvatarUrl,
          appointments: appointments,
          upcomingAppointmentIndex: upcomingAppointmentIndex,
          upcomingCustomerName: upcomingCustomerName,
          appointmentInDate: appointmentMap,
          selectedDate: DateTime.now(),
        ),
      );
    } catch (e) {
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Cannot load the appointment and doctor info',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
  }

  void _onDoctorHomeResetEvent(
    DoctorHomeResetEvent event,
    Emitter<DoctorHomeState> emit,
  ) {
    emit(DoctorHomeInitial.from(state));
  }

  // Future<void> _onPrescriptionCheckEvent(
  //   PrescriptionCheckEvent event,
  //   Emitter<DoctorHomeState> emit,
  // ) async {
  //   if (state is PrescriptionViewLoadingState) {
  //     return;
  //   }
  //   if (state is! DoctorHomeViewState) {
  //     return emit(DoctorHomeViewState.initial());
  //   }
  //   try {
  //     emit(PrescriptionViewLoadingState.fromState(state));

  //     await Future.delayed(const Duration(seconds: 1), () {}); // Mock delay

  //     // throw Exception('Error');

  //     emit(DoctorHomeViewState.initial());
  //   } catch (error) {
  //     emit(DoctorHomeViewState.initial());
  //     await _notificationManagerService.show<void>(
  //       NotificationType.error,
  //       title: const Text('Error'),
  //       message: const Text('An error occured while loading the prescription.'),
  //     );
  //   }
  // }

  void _onDoctorHomeOpenDoctorScheduleViewEvent(
    DoctorHomeOpenDoctorScheduleViewEvent event,
    Emitter<DoctorHomeState> emit,
  ) {
    emit(
      DoctorScheduleViewState(
        doctorName: state.doctorName,
        doctorAvatarUrl: state.doctorAvatarUrl,
        appointments: state.appointments,
        upcomingAppointmentIndex: state.upcomingAppointmentIndex,
        upcomingCustomerName: state.upcomingCustomerName,
        appointmentInDate: state.appointmentInDate,
        selectedDate: event.date,
      ),
    );
  }

  void _onDoctorHomeOpenCancelAppointmentViewEvent(
    DoctorHomeOpenCancelAppointmentViewEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
   try {
      // remove this 2 lines when login is done and doctor id is passed from login screen
      if (state.upcomingAppointmentIndex != 1)
       await _doctorRepositoryService!.cancelAppointment(
        Appointment(
          customerID : state.appointments[state.upcomingAppointmentIndex]['customerID'],
          doctorID : state.appointments[state.upcomingAppointmentIndex]['doctorID'],
          period : state.appointments[state.upcomingAppointmentIndex]['period'],
          date : state.appointments[state.upcomingAppointmentIndex]['date'],
          rating : state.appointments[state.upcomingAppointmentIndex]['rating'],
          customerComment : state.appointments[state.upcomingAppointmentIndex]['customerComment'],
          prescriptionID : state.appointments[state.upcomingAppointmentIndex]['prescriptionID'],
          dateDone : state.appointments[state.upcomingAppointmentIndex]['dateDone'],
          done : state.appointments[state.upcomingAppointmentIndex]['done'],
          note : state.appointments[state.upcomingAppointmentIndex]['note'],
          diagnosis : state.appointments[state.upcomingAppointmentIndex]['diagnosis'],
          isCanceled : true,
        ));
      // get doctor name after changing the doctor table in the database
      // final String doctorAvatarUrl = profileData['imgPath'];
      // just hard code for now
      
      emit(
        DoctorHomeLoadedSuccess(
          doctorName: state.doctorName,
          doctorAvatarUrl: state.doctorAvatarUrl,
          appointments: state.appointments,
          upcomingAppointmentIndex: state.upcomingAppointmentIndex,
          upcomingCustomerName: state.upcomingCustomerName,
          appointmentInDate: state.appointmentInDate,
          selectedDate: state.selectedDate,
        ),
      );
    } catch (e) {
      await _notificationManagerService.show<void>(
        _navigatorKey.currentContext!,
        NotificationType.error,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Cannot load the appointment and doctor info',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
  }


}
