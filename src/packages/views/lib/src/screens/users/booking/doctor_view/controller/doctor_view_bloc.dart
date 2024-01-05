// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'doctor_view_event.dart';
part 'doctor_view_state.dart';

class DoctorViewBloc extends Bloc<DoctorViewEvent, DoctorViewState> {
  DoctorViewBloc(
    this._customerRepositoryService,
  ) : super(const DoctorViewInitial()) {
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

  final CustomerRepositoryService _customerRepositoryService;

  Future<List<String>> getDoctorSpecialization() =>
      _customerRepositoryService.getDoctorSpecialization();

  Future<List<String>> getAvailableAppointmentTimes(
    String doctorID,
    DateTime date,
  ) async {
    final customerid = _customerRepositoryService.getCustomerId();
    final availablePeriods = await _customerRepositoryService
        .getAvailablePeriod(doctorID, date, customerid!);

    // Extract 'time' values from the list and format them with leading zeros
    final appointmentTimes = availablePeriods.map(
      (period) {
        final time = period['time'] as String;
        final formattedTime =
            DateFormat('HH:mm a').format(DateTime.parse('2022-01-01 $time'));
        return formattedTime;
      },
    ).toList();

    return appointmentTimes;
  }

  Future<List<Map<String, dynamic>>> getAvaiableDoctors() =>
      _customerRepositoryService.getAvailableDoctors(
        rating: (state.filteredRating != 'All')
            ? int.parse(state.filteredRating)
            : null,
        specialities: (state.filteredSpecialties != const ['All'])
            ? state.filteredSpecialties
            : null,
        searchName: state is DoctorViewSearchForName
            ? (state as DoctorViewSearchForName).searchedName
            : null,
      );

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
    if (event.rating == state.filteredRating) {
      emit(
        state.copyWith(
          filteredRating: 'All',
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        filteredRating: event.rating,
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
        filteredRating: 'All',
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
