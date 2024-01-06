// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'doctor_absent_event.dart';
part 'doctor_absent_state.dart';

class DoctorAbsentBloc extends Bloc<DoctorAbsentEvent, DoctorAbsentState> {
  DoctorAbsentBloc(
    this._doctorRepositoryService,
  ) : super(const DoctorAbsentInitial()) {
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
        final dateComps = state.date.split('/');
        final date = DateTime(
          int.parse(dateComps[2]),
          int.parse(dateComps[1]),
          int.parse(dateComps[0]),
        );
        await _doctorRepositoryService.sendAbsentRequest(
          reasons: state.reasons,
          date: date,
          doctorName: state.profileData['fullname'] as String,
        );

        /// Then emit the success state
        emit(const DoctorAbsentSuccess());
      } on TimeoutException catch (_) {
        emit(
          DoctorAbsentError.fromState(
            state: state,
            errorMessage: 'Request timed out',
          ),
        );
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

  final DoctorRepositoryService _doctorRepositoryService;

  Future<Map<String, dynamic>> getProfileData() async =>
      _doctorRepositoryService.getProfileData();
}
