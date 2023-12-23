import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
//import 'package:utility/utility.dart';

part 'doctor_home_event.dart';
part 'doctor_home_state.dart';

class DoctorHomeBloc extends Bloc<DoctorHomeEvent, DoctorHomeState> {
  DoctorHomeBloc(
    //this._notificationManagerService,
  ) : super(DoctorHomeViewState.initial()) {
    on<DoctorHomeOpenDoctorScheduleViewEvent>(
        _onDoctorHomeOpenDoctorScheduleViewEvent);
    on<DoctorHomeResetEvent>(_onDoctorHomeResetEvent);
    on<DoctorHomeOpenCancelAppointmentViewEvent> (_onDoctorHomeOpenCancelAppointmentViewEvent);
  }

  @override
  void onTransition(
      Transition<DoctorHomeEvent, DoctorHomeState> transition) {
    debugPrint(transition.toString());
    super.onTransition(transition);
  }

  //final NotificationManagerService _notificationManagerService;


// for doctor home screen
  Future<List<Map<String, dynamic>>> getAllAppointment() => Future.delayed(
        const Duration(seconds: 1),
        () => [
          {
            'customerName': 'Nguyen Van A',
            'date': DateTime.now(),
            //'Note': //'Note',
            'id': 'P001',
          },
          {
            'customerName': 'Nguyen Van B',
            'date': DateTime.now(),
            //'Note': //'Note',
            'id': 'P002',
          },
          {
            'customerName': 'Nguyen Van C',
            'date': DateTime.now(),
            //'Note': //'Note',
            'id': 'P003',
          },
        ],
      );



  Future<List<Map<String, dynamic>>> getUpcomingAppointment() => Future.delayed(
        const Duration(seconds: 1),
        () => [
          {
            'customerName': 'Nguyen Van D',
            'date': DateTime.now(),
            //'Note': //'Note',
            'id': 'P004',
          },
          // {
          //   'customerName': 'Nguyen Van A',
          //   'date': DateTime.now(),
          //   //'Note': //'Note',
          //   'id': 'P002',
          // },
          // {
          //   'customerName': 'Nguyen Van A',
          //   'date': DateTime.now(),
          //   //'Note': //'Note',
          //   'id': 'P003',
          // },
        ],
      );

// for doctor schedule screen
  Future<List<Map<String, dynamic>>> getNextAppointment() => Future.delayed(
        const Duration(seconds: 1),
        () => [
          {
            'customerName': 'Nguyen Van E',
            'time': '2:00 PM',
            //'Note': //'Note',
            'symptom': 'headache',
            'id': 'P0010',

          },
          {
            'customerName': 'Nguyen Van F',
            'time': '2:00 PM',
            //'Note': //'Note',
            'symptom': 'headache',
            'id': 'P0011',

          },
          {
            'customerName': 'Nguyen Van G',
            'time': '2:00 PM',
            //'Note': //'Note',
            'symptom': 'headache',
            'id': 'P0012',
          },
        ],
      );

  Future<List<Map<String, dynamic>>> getPastAppointment() => Future.delayed(
        const Duration(seconds: 1),
        () => [
          {
            'customerName': 'Nguyen Van H',
            'time': '2:00 PM',
            //'Note': //'Note',
            'symptom': 'Asthma',
            'id': 'P0013',
          },
          {
            'customerName': 'Nguyen Van J',
            'time': '2:00 PM',
            //'Note': //'Note',
            'symptom': 'heart attack',
            'id': 'P0014',
          },
        ],
      );

  void _onDoctorHomeResetEvent(
    DoctorHomeResetEvent event,
    Emitter<DoctorHomeState> emit,
  ) {
    emit(DoctorHomeViewState.initial());
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
      DoctorScheduleViewState.fromState(
        state,
        //customerID: event.customerID,
      ),
    );
  }

  void _onDoctorHomeOpenCancelAppointmentViewEvent(
    DoctorHomeOpenCancelAppointmentViewEvent event,
    Emitter<DoctorHomeState> emit,
  ) async{ }
  // Future<void> _onMedicineCheckEvent(
  //   MedicineCheckEvent event,
  //   Emitter<DoctorHomeState> emit,
  // ) async {
  //   if (state is MedicinesViewLoadingState) {
  //     return;
  //   }
  //   if (state is! DoctorScheduleViewState) {
  //     return emit(DoctorHomeViewState.initial());
  //   }
  //   try {
  //     emit(MedicinesViewLoadingState.fromState(state));

  //     await Future.delayed(const Duration(seconds: 1), () {}); // Mock delay

  //     emit(DoctorScheduleViewState.fromState(state));
  //   } catch (error) {
  //     emit(MedicinesViewLoadingState.fromState(state));
  //     await _notificationManagerService.show<void>(
  //       NotificationType.error,
  //       title: const Text('Error'),
  //       message: const Text('An error occured while processing the medicine.'),
  //     );
  //   }
  // }

  // void _onMedicineOpenIntakeViewEvent(
  //   OpenIntakeViewEvent event,
  //   Emitter<DoctorHomeState> emit,
  // ) {
  //   if (state is! DoctorScheduleViewState) {
  //     return emit(DoctorHomeViewState.initial());
  //   }
  //   emit(
  //     IntakeViewState.fromState(state),
  //   );
  // }

  // void _onIntakeRatingEvent(
  //   IntakeRatingEvent event,
  //   Emitter<DoctorHomeState> emit,
  // ) {}
}