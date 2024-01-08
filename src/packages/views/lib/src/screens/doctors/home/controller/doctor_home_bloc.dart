// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      _onDoctorHomeOpenDoctorScheduleViewEvent,
    );
    on<DoctorHomeResetEvent>(_onDoctorHomeResetEvent);
    on<DoctorHomeOpenCancelAppointmentViewEvent>(
      _onDoctorHomeOpenCancelAppointmentViewEvent,
    );
  }
  final DoctorRepositoryService _doctorRepositoryService;
  //final AuthenticationRepositoryService authenticationRepositoryService;
  final GlobalKey<NavigatorState> _navigatorKey;
  final NotificationManagerService _notificationManagerService;

  Future<void> _onDoctorHomeLoadEvent(
    DoctorHomeLoadEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
    try {
      // ignore: lines_longer_than_80_chars
      // remove this 2 lines when login is done and doctor id is passed from login screen

      final appointments =
          await _doctorRepositoryService.getAppointmentsByDoctorId();
      final dynamic profileData =
          await _doctorRepositoryService.getProfileData();
      final doctorName = profileData['fullName'].toString();

      // get doctor name after changing the doctor table in the database
      final doctorAvatarUrl = profileData['imageUrl'] == null
          ? 'https://pics.craiyon.com/2023-07-05/a8e9e1290f08447bb300681ce2b563e9.webp'
          : profileData['imageUrl'] as String;
      // just hard code for now
      // const doctorAvatarUrl =
      //     'https://pics.craiyon.com/2023-07-05/a8e9e1290f08447bb300681ce2b563e9.webp';

      var upcomingAppointmentIndex = -1;
      var upcomingCustomerName = '';
      final appointmentMap = <String, List<dynamic>>{};
      // ignore: lines_longer_than_80_chars
      // get the index of the upcoming appointment, which is after current time and closest to current time
      // also map the appointments to each date
      for (var i = 0; i < appointments.length; i++) {
        if (appointments[i]['customerName'] == null ||
            appointments[i]['customerName'] == 'null') {
          appointments[i]['customerName'] = 'On-site Customer';
        }
        if (appointments[i]['isCanceled'] == true) continue;
        final tmp = DateTime.parse(appointments[i]['date'].toString());
        //tmp = DateTime(tmp.year, tmp.month, tmp.day, 0, 0, 0);
        final hour = int.parse(appointments[i]['period'].toString()) ~/ 2 + 7;
        final minute =
            (int.parse(appointments[i]['period'].toString()) % 2) * 30;
        final exactTime = DateTime(tmp.year, tmp.month, tmp.day, hour, minute);

        if (exactTime.isAfter(DateTime.now()) ||
            exactTime.isAtSameMomentAs(DateTime.now())) {
          if (appointments[i]['done'] != true &&
              appointments[i]['done'] != 'true') {
            if (upcomingAppointmentIndex == -1 ||
                tmp.isBefore(
                  DateTime.parse(
                    appointments[upcomingAppointmentIndex]['date'].toString(),
                  ),
                ) ||
                (tmp.isAtSameMomentAs(
                      DateTime.parse(
                        appointments[upcomingAppointmentIndex]['date']
                            .toString(),
                      ),
                    ) &&
                    int.parse(appointments[i]['period'].toString()) <
                        int.parse(
                          appointments[upcomingAppointmentIndex]['period']
                              .toString(),
                        ))) {
              upcomingAppointmentIndex = i;
            }
          }
        }
        final convertedDate = '${tmp.year}-${tmp.month}-${tmp.day}';
        if (appointmentMap.containsKey(convertedDate)) {
          appointmentMap[convertedDate]!.add(appointments[i]);
        } else {
          appointmentMap[convertedDate] = [appointments[i]];
        }
      }

      if (upcomingAppointmentIndex != -1) {
        upcomingCustomerName =
            appointments[upcomingAppointmentIndex]['customerName'].toString();
      } else {
        upcomingCustomerName = 'no appointment';
      }

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

  Future<void> _onDoctorHomeOpenCancelAppointmentViewEvent(
    DoctorHomeOpenCancelAppointmentViewEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
    try {
      final appointment = Appointment(
        customerID: event.appointment['customerID'].toString(),
        doctorID: event.appointment['doctorID'].toString(),
        period: int.parse(event.appointment['period'].toString()),
        date: DateTime.parse(event.appointment['date'].toString()),
        rating: (event.appointment['rating'].toString() == 'null'
            ? null
            : int.parse(event.appointment['rating'].toString())),
        customerComment:
            (event.appointment['customerComment'].toString() == 'null' ||
                    event.appointment['customerComment'].toString() == '')
                ? null
                : event.appointment['customerComment'].toString(),
        prescriptionID: event.appointment['prescriptionID'].toString() == 'null'
            ? null
            : event.appointment['prescriptionID'].toString(),
        dateDone: event.appointment['dateDone'].toString() == 'null'
            ? null
            : DateTime.parse(event.appointment['dateDone'].toString()),
        done: event.appointment['done'].toString() == 'true' ? true : false,
        note: event.appointment['note'].toString() == 'null'
            ? null
            : event.appointment['note'].toString(),
        diagnosis: event.appointment['diagnosis'].toString() == 'null'
            ? null
            : event.appointment['diagnosis'].toString(),
        isCanceled: true,
        customerName:
            event.appointment['customerName'].toString() == 'On-site Customer'
                ? null
                : event.appointment['customerName'].toString(),
        prescriptionDone: event.appointment['prescriptionDone'].toString() == 'true' ? true : false,
      );
      await _doctorRepositoryService.cancelAppointment(appointment);

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
