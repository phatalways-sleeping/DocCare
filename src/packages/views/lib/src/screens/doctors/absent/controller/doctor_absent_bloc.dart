// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'doctor_absent_event.dart';
part 'doctor_absent_state.dart';

class DoctorAbsentBloc extends Bloc<DoctorAbsentEvent, DoctorAbsentState> {
  DoctorAbsentBloc() : super(const DoctorAbsentInitial()) {
    on<DoctorAbsentResetEvent>((event, emit) {
      emit(
        DoctorAbsentInitial.fromState(
          state: state,
        ),
      );
    });
    on<DoctorAbsentDateInputEvent>((event, emit) {
      emit(state.copyWith(date: event.date));
    });
    on<DoctorAbsentDescriptionInputEvent>((event, emit) {
      emit(state.copyWith(reasons: event.reasons));
    });
    on<DoctorAbsentAgreementCheckboxEvent>((event, emit) {
      emit(state.copyWith(agreeTerms: event.agreed));
    });
    on<DoctorAbsentArrangeAnotherDoctorEvent>((event, emit) {
      emit(state.copyWith(arrangeAnotherDoctor: event.arrangeAnotherDoctor));
    });
    on<DoctorAbsentButtonPressedEvent>((event, emit) async {
      if (state.date.isEmpty || state.reasons.isEmpty || !state.agreeTerms) {
        return emit(
          DoctorAbsentError.fromState(
            state: state,
            errorMessage: 'Either date, reasons or agree terms is empty',
          ),
        );
      }
      try {
        emit(DoctorAbsentLoading.fromState(state: state));

        await Future.delayed(const Duration(seconds: 4), () {});

        // throw Exception('An error occured while trying to submit the form');

        /// Use doctor repo api to call the api to submit the form
        /// Then emit the success state
        emit(const DoctorAbsentSuccess());
      } catch (error) {
        emit(
          DoctorAbsentError.fromState(
            state: state,
            errorMessage: 'An error occured while trying to submit the form',
          ),
        );
      }
    });
  }
}
