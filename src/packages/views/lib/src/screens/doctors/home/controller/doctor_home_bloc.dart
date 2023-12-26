import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:controllers/controllers.dart';
import 'package:models/models.dart';
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
        if (appointmentMap.containsKey(convertedDate)) {
          appointmentMap[convertedDate]!.add(appointments[i]);
        } else {
          appointmentMap[convertedDate] = [appointments[i]];
        }
      }
      if (upcomingAppointmentIndex != -1) {
        upcomingCustomerName =
            appointments[upcomingAppointmentIndex]['customerName'];
      } else
        upcomingCustomerName = 'no appointment';

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
      Appointment appointment = Appointment(
        customerID: event.appointment['customerID'],
        doctorID: event.appointment['doctorID'],
        period: event.appointment['period'],
        date: DateTime.parse(event.appointment['date']),
        rating: event.appointment['rating'],
        customerComment: event.appointment['customerComment'],
        prescriptionID: event.appointment['prescriptionID'],
        dateDone: event.appointment['dateDone'],
        done: event.appointment['done'],
        note: event.appointment['note'],
        diagnosis: event.appointment['diagnosis'],
        isCanceled: true,
        customerName: event.appointment['customerName'],
      );
      await _doctorRepositoryService!.cancelAppointment(appointment);
      emit(DoctorHomeInitial.from(state));
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
