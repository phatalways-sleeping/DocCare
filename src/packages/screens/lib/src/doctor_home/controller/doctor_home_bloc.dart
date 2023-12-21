import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:model_api/model_api.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'doctor_home_event.dart';
part 'doctor_home_state.dart';

class DoctorHomeBloc extends Bloc<DoctorHomeEvent, DoctorHomeState> {
  DoctorHomeBloc(
    this.ID,
    this.doctorName,
    this._appointmentApiService,
    this._customerApiService,
 //   this._doctorAPIService,
  ) : super(DoctorHomeInitial.empty()) {
    on<DoctorHomeInitialEvent>(_onDoctorHomeInitialEvent);    
    on<DoctorSelectDateEvent>(_onDoctorSelectDateEvent);
    on<DoctorScheduleBackEvent>(_onDoctorScheduleBackEvent);
  }

  final String ID;
  final String doctorName;
  final SupabaseAppointmentApiService _appointmentApiService;
  final SupabaseCustomerApiService _customerApiService;
//  final SupabaseDoctorApiService _doctorAPIService;

  void _onDoctorHomeInitialEvent(
    DoctorHomeInitialEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
    try {
      final customerName = <String>[];
      final period = <int>[];
      final date = <DateTime>[];
      final customerComment = <String?>[];
      final currentDay = DateTime.now();
      emit(DoctorHomeInitial.empty());
      final appointments = await _appointmentApiService
          .getAppointmentsByDoctorId(ID)
          .then((value) {
        for (final element in value) {
          customerName.add(element.customerID);
          period.add(element.period);
          date.add(element.date);
          customerComment.add(element.customerComment);
        }
      });

      for (var i = 0; i < customerName.length; i++) {
        final customer = await _customerApiService
            .getUser(customerName[i])
            .then((value) => customerName[i] = value.fullname);
      }

      emit(
        DoctorHomeInitial.input(
          customerName: customerName,
          period: period,
          date: date,
          customerComment: customerComment,
          currentDay: currentDay,
        ),
      );
    } catch (e) {
      return;
    }
  }

  void _onDoctorSelectDateEvent(
    DoctorSelectDateEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
    try {
      // final medicineName = <String>[];
      // final quantity = <int?>[];
      // final toBeTaken = <int?>[];
      // final timeOfTheDay = <String?>[];

      emit(
        DoctorHomeLoading(
          customerName: state.customerName,
          period: state.period,
          date: state.date,
          customerComment: state.customerComment,
          currentDay: state.currentDay,
        ),
      );

      try {
        // final intake = await _intakeAPIService
        //     .getIntakeListByPrescriptionID(event.prescriptionID)
        //     .then((value) {
        //   for (final element in value) {
        //     medicineName.add(element.medicineName);
        //     quantity.add(element.quantity);
        //     toBeTaken.add(element.toBeTaken);
        //     timeOfTheDay.add(element.timeOfTheDay);
        //   }
        // });
        



      } catch (e) {
        emit(
          (state as DoctorHomeLoading).toggleBackToInitial(),
        );
        return;
      }

      emit(
        DoctorScheduleInitial(
          customerName: state.customerName,
          period: state.period,
          date: state.date,
          customerComment: state.customerComment,
          currentDay: state.currentDay,
          // medicineName: medicineName,
          // quantity: quantity,
          // toBeTaken: toBeTaken,
          // timeOfTheDay: timeOfTheDay,
          // currentPrescriptionID: event.prescriptionID,
          // clickedIndex: event.index,
        ),
      );
    } catch (e) {
      return;
    }
  }

  void _onDoctorScheduleBackEvent(
    DoctorScheduleBackEvent event,
    Emitter<DoctorHomeState> emit,
  ) async {
    emit(
      DoctorHomeInitial.input(
        customerName: state.customerName,
        period: state.period,
        date: state.date,
        customerComment: state.customerComment,
        currentDay: state.currentDay,
        // prescriptionID: state.prescriptionID,
        // doctorName: state.doctorName,
        // datePrescribed: state.datePrescribed,
        // note: state.note,
        // done: state.done,
        // diagnosis: state.diagnosis,
      ),
    );
  }

//   FutureOr<void> _onPrescriptionReviewEvent(
//     PrescriptionReviewEvent event,
//     Emitter<DoctorHomeState> emit,
//   ) async { 
//   try {
//     final doctorID = <String>[];

//     final prescription = await _prescriptionAPIService
//           .getAllPrescriptionListByCustomerID(ID)
//           .then((value) {
//         for (final element in value) {
//           doctorID.add(element.doctorID);
//         }
//       });

//     emit(
//       PrescriptionLoading(
//           prescriptionID: state.prescriptionID,
//           doctorName: state.doctorName,
//           datePrescribed: state.datePrescribed,
//           note: state.note,
//           done: state.done,
//           diagnosis: state.diagnosis,
//         ),
//       );

//       final SupabaseClient client = Supabase.instance.client;

//       print(ID);
//       print(doctorID[event.index]);
//       print(state.datePrescribed[event.index].toString());
//       print(event.rating);

//       await client.rpc('sp_update_appointment_rating', params: {
//         'n_period': 1,
//         'n_customer_id': ID,
//         'n_doctor_id': doctorID[event.index],
//         'n_date': state.datePrescribed[event.index].toString(),
//         'n_rating': event.rating,
//       },);

//       emit(
//         DoctorHomeInitial.input(
//           prescriptionID: state.prescriptionID,
//           doctorName: state.doctorName,
//           datePrescribed: state.datePrescribed,
//           note: state.note,
//           done: state.done,
//           diagnosis: state.diagnosis,
//         ),
//       );
//   }
//   catch (e) {
//     print(e);

//     emit(
//         DoctorHomeInitial.input(
//           prescriptionID: state.prescriptionID,
//           doctorName: state.doctorName,
//           datePrescribed: state.datePrescribed,
//           note: state.note,
//           done: state.done,
//           diagnosis: state.diagnosis,
//         ),
//       );

//     return;
//   }
// }

  // FutureOr<void> _onPrescriptionOnTickEvent(
  //   PrescriptionOnTickEvent event,
  //   Emitter<DoctorHomeState> emit,
  // ) async {
  //   try {
  //     emit(
  //       PrescriptionLoading(
  //         prescriptionID: state.prescriptionID,
  //         doctorName: state.doctorName,
  //         datePrescribed: state.datePrescribed,
  //         note: state.note,
  //         done: state.done,
  //         diagnosis: state.diagnosis,
  //       ),
  //     );

  //     await _prescriptionAPIService.updatePrescriptionDone(
  //       state.prescriptionID[event.index],
  //       state.done[event.index] ? false : true,
  //       DateTime.now(),
  //     );

  //     final done = <bool>[];
  //     final prescription = await _prescriptionAPIService
  //         .getAllPrescriptionListByCustomerID(ID)
  //         .then((value) {
  //       for (var i = 0; i < state.prescriptionID.length; i++) {
  //         for (final element in value) {
  //           if (element.id == state.prescriptionID[i]) {
  //             done.add(element.done);
  //           }
  //         }
  //       }
  //     });
  //     emit(
  //       DoctorHomeInitial.input(
  //         prescriptionID: state.prescriptionID,
  //         doctorName: state.doctorName,
  //         datePrescribed: state.datePrescribed,
  //         note: state.note,
  //         done: done,
  //         diagnosis: state.diagnosis,
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //     return;
  //   }
  // }
}