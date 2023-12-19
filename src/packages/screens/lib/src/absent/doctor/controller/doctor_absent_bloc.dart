// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'doctor_absent_event.dart';
part 'doctor_absent_state.dart';
class DoctorAbsentBloc extends Bloc<DoctorAbsentEvent, DoctorAbsentState> {
  DoctorAbsentBloc() : super(const DoctorAbsentInitial()) {
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
    on<DoctorAbsentButtonPressedEvent>((event, emit) {
      emit(DoctorAbsentLoading(
        date: state.date,
        reasons: state.reasons,
        agreeTerms: state.agreeTerms,
        arrangeAnotherDoctor: state.arrangeAnotherDoctor,
      ));
      if(state.date.isEmpty || state.reasons.isEmpty || !state.agreeTerms) {
        emit(DoctorAbsentInitial(
          date: state.date,
          reasons: state.reasons,
          agreeTerms: state.agreeTerms,
          arrangeAnotherDoctor: state.arrangeAnotherDoctor,
        ));
        return;
      }

      /// Inject doctor repository service here
      emit(const DoctorAbsentSuccess());
    });
  }
}
