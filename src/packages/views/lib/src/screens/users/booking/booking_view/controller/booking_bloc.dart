// ignore_for_file: public_member_api_docs, avoid_redundant_argument_values

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

int convertTimeToPeriodId(String time) {
  try {
    const startHour = 7;
    const startMinute = 30;

    final currentHour = int.parse(time.substring(0, 2));
    final currentMinute = int.parse(time.substring(3, 5));

    final periodId =
        ((currentHour - startHour) * 60 + (currentMinute - startMinute)) ~/ 30 +
            1;

    return periodId; // Adjusted to match the previous logic
  } catch (e) {
    // Handle parsing errors
    print("Error parsing time: $e");
    throw Exception("Error parsing time");
  }
}

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc(
    this._customerRepositoryService, {
    Map<String, dynamic> doctorData = const {},
  }) : super(
          BookingInitial(
            doctorData: doctorData,
          ),
        ) {
    on<BookingSelectDateEvent>(_onBookingSelectDateEvent);
    on<BookingSelectTimeEvent>(_onBookingSelectTimeEvent);
    on<BookingSelectSpecialityEvent>(_onBookingSelectSpecialityEvent);
    on<BookingSelectRemindMeBeforeEvent>(_onBookingSelectRemindMeBeforeEvent);
    on<BookingEnterSymptomEvent>(_onBookingEnterSymptomEvent);
    on<BookingConfirmEvent>(_onBookingConfirmEvent);
    on<BookingResetEvent>(_onBookingResetEvent);
    on<BookingBackToInitialEvent>(_onBookingBackToInitialEvent);
  }

  final CustomerRepositoryService _customerRepositoryService;

  void _onBookingBackToInitialEvent(
    BookingBackToInitialEvent event,
    Emitter<BookingState> emit,
  ) {
    emit(
      BookingInitial(
        doctorData: state.doctorData,
      ),
    );
  }

  void _onBookingResetEvent(
    BookingResetEvent event,
    Emitter<BookingState> emit,
  ) {
    emit(
      BookingInitial.fromState(
        state: state,
      ),
    );
  }

  Future<List<String>> getDoctorSpecialization() =>
      _customerRepositoryService.getDoctorSpecialization();

  Future<void> _onBookingConfirmEvent(
    BookingConfirmEvent event,
    Emitter<BookingState> emit,
  ) async {
    // Emit the loading state
    emit(
      BookingLoadingRequest.fromState(state: state),
    );

    final doctorData = state.doctorData;

    try {
      // Calling the domain layer
      // Mocking the API call
      //await Future.delayed(const Duration(seconds: 5), () {});
      // Mocking error
      // throw Exception();
      final time = convertTimeToPeriodId(state.timeSelected!);
      final customerid = _customerRepositoryService.getCustomerId();
      final doctorid = doctorData['id'] as String;
      final date = state.dateSelected;
      final customerComment = state.symptom;
      await _customerRepositoryService.bookAppointmentWithDoctor(
        period: time,
        customerid: customerid,
        doctorid: doctorid,
        date: date!,
        customerComment: customerComment,
      );
      // Emit the success state
      // If user books without selecting a doctor, the doctorData will be passed
      // from the response of the booking API
      // final doctorData = oldDoctorData.isEmpty
      //     ? {
      //         'name': 'Dr. John Doe',
      //         'speciality': 'Dentist',
      //         'imgPath': 'https://picsum.photos/200',
      //         'rating': 4.5,
      //         'ratingCount': 100,
      //       }
      //     : oldDoctorData;
      emit(
        BookingSuccess(
          doctorData: doctorData,
          timeSelected: state.timeSelected,
          dateSelected: state.dateSelected,
        ),
      );
    } catch (err) {
      emit(
        BookingFailure(
          doctorData: doctorData,
          error:
              'An error occurred while booking the appointment.\nPlease try again later.',
        ),
      );
    }
  }

  void _onBookingSelectSpecialityEvent(
    BookingSelectSpecialityEvent event,
    Emitter<BookingState> emit,
  ) {
    emit(
      state.copyWith(
        speciality: event.speciality,
      ),
    );
  }

  void _onBookingEnterSymptomEvent(
    BookingEnterSymptomEvent event,
    Emitter<BookingState> emit,
  ) {
    emit(
      state.copyWith(
        symptom: event.symptom,
      ),
    );
  }

  void _onBookingSelectRemindMeBeforeEvent(
    BookingSelectRemindMeBeforeEvent event,
    Emitter<BookingState> emit,
  ) {
    if (event.remindMeBefore == state.remindMeBefore) {
      emit(
        state.copyWith(
          remindMeBefore: null,
          cascadeRemindMeBefore: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        remindMeBefore: event.remindMeBefore,
      ),
    );
  }

  void _onBookingSelectTimeEvent(
    BookingSelectTimeEvent event,
    Emitter<BookingState> emit,
  ) {
    if (event.time == state.timeSelected) {
      emit(
        state.copyWith(
          timeSelected: null,
          cascadeTimeSelected: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        timeSelected: event.time,
      ),
    );
  }

  void _onBookingSelectDateEvent(
    BookingSelectDateEvent event,
    Emitter<BookingState> emit,
  ) {
    if (event.date == state.dateSelected) {
      emit(
        state.copyWith(
          dateSelected: null,
          timeSelected: null,
          remindMeBefore: null,
          cascadeDateSelected: false,
          cascadeTimeSelected: false,
          cascadeRemindMeBefore: false,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        dateSelected: event.date,
        timeSelected: null,
        remindMeBefore: null,
        cascadeTimeSelected: false,
        cascadeRemindMeBefore: false,
      ),
    );
  }

  @override
  void onChange(Change<BookingState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
