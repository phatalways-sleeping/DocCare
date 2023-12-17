// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'doctor_view_event.dart';
part 'doctor_view_state.dart';

class DoctorViewBloc extends Bloc<DoctorViewEvent, DoctorViewState> {
  DoctorViewBloc() : super(const DoctorViewInitial()) {
    on<DoctorViewInitialEvent>(_onDoctorViewInitialEvent);
    on<DoctorViewFilterEvent>(_onDoctorViewFilterEvent);
    on<DoctorViewStartSearchForNameEvent>(_onDoctorViewStartSearchForNameEvent);
    on<DoctorViewSearchForNameEvent>(_onDoctorViewSearchForNameEvent);
    on<DoctorViewFilterSpecialtyEvent>(_onDoctorViewFilterSpecialtyEvent);
    on<DoctorViewFilterRatingEvent>(_onDoctorViewFilterRatingEvent);
    on<DoctorViewResetFiltersEvent>(_onDoctorViewResetFiltersEvent);
    on<DoctorViewApplyFiltersEvent>(_onDoctorViewApplyFiltersEvent);
    on<DoctorViewChooseDoctorEvent>(_onDoctorViewChooseDoctorEvent);
  }

  void _onDoctorViewChooseDoctorEvent(
    DoctorViewChooseDoctorEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      DoctorViewChooseDoctor(doctor: event.doctor),
    );
  }

  void _onDoctorViewStartSearchForNameEvent(
    DoctorViewStartSearchForNameEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      DoctorViewSearchForName.fromState(
        state: state,
        searchedName: '',
      ),
    );
  }

  void _onDoctorViewInitialEvent(
    DoctorViewInitialEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      DoctorViewInitial.fromState(
        state: state,
      ),
    );
  }

  void _onDoctorViewFilterEvent(
    DoctorViewFilterEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      DoctorViewFilter.fromState(
        state: state,
      ),
    );
  }

  void _onDoctorViewSearchForNameEvent(
    DoctorViewSearchForNameEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      DoctorViewSearchForName.fromState(
        state: state,
        searchedName: event.searchedName,
      ),
    );
  }

  void _onDoctorViewFilterSpecialtyEvent(
    DoctorViewFilterSpecialtyEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    if (event.specialty == 'All') {
      emit(
        state.copyWith(
          filteredSpecialties: const ['All'],
        ),
      );
      return;
    }
    final currentSpecialties = [...state.filteredSpecialties];
    if (currentSpecialties.contains('All')) {
      currentSpecialties.remove('All');
    }
    if (currentSpecialties.contains(event.specialty)) {
      currentSpecialties.remove(event.specialty);
      if (currentSpecialties.isEmpty) {
        currentSpecialties.add('All');
      }
    } else {
      currentSpecialties.add(event.specialty);
    }
    emit(
      state.copyWith(
        filteredSpecialties: currentSpecialties,
      ),
    );
  }

  void _onDoctorViewFilterRatingEvent(
    DoctorViewFilterRatingEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    if (event.rating == 'All') {
      emit(
        state.copyWith(
          filteredRating: const ['All'],
        ),
      );
      return;
    }
    final currentRating = [...state.filteredRating];
    if (currentRating.contains('All')) {
      currentRating.remove('All');
    }
    if (currentRating.contains(event.rating)) {
      currentRating.remove(event.rating);
      if (currentRating.isEmpty) {
        currentRating.add('All');
      }
    } else {
      currentRating.add(event.rating);
    }
    emit(
      state.copyWith(
        filteredRating: currentRating,
      ),
    );
  }

  void _onDoctorViewResetFiltersEvent(
    DoctorViewResetFiltersEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      state.copyWith(
        filteredSpecialties: const ['All'],
        filteredRating: const ['All'],
      ),
    );
  }

  void _onDoctorViewApplyFiltersEvent(
    DoctorViewApplyFiltersEvent event,
    Emitter<DoctorViewState> emit,
  ) {
    emit(
      DoctorViewLoading.fromState(state: state, searchedName: ''),
    );
  }
}
