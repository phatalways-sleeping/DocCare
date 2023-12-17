// ignore_for_file: public_member_api_docs, avoid_redundant_argument_values

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    Map<String, dynamic> doctorData = const {},
  }) : super(BookingInitial(
          doctorData: doctorData,
        )) {
    on<BookingSelectDateEvent>(_onBookingSelectDateEvent);
    on<BookingSelectTimeEvent>(_onBookingSelectTimeEvent);
    on<BookingSelectRemindMeBeforeEvent>(_onBookingSelectRemindMeBeforeEvent);
    on<BookingEnterSymptomEvent>(_onBookingEnterSymptomEvent);
    on<BookingConfirmEvent>(_onBookingConfirmEvent);
  }

  void _onBookingConfirmEvent(
    BookingConfirmEvent event,
    Emitter<BookingState> emit,
  ) {}

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
}
