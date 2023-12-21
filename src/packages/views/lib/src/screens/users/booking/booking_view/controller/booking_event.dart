// ignore_for_file: public_member_api_docs

part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

final class BookingSelectDateEvent extends BookingEvent {
  const BookingSelectDateEvent({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object?> get props => [
        date,
      ];
}

final class BookingSelectTimeEvent extends BookingEvent {
  const BookingSelectTimeEvent({
    required this.time,
  });

  final String time;

  @override
  List<Object?> get props => [
        time,
      ];
}

final class BookingSelectRemindMeBeforeEvent extends BookingEvent {
  const BookingSelectRemindMeBeforeEvent({
    required this.remindMeBefore,
  });

  final String remindMeBefore;

  @override
  List<Object?> get props => [
        remindMeBefore,
      ];
}

final class BookingSelectSpecialityEvent extends BookingEvent {
  const BookingSelectSpecialityEvent({
    required this.speciality,
  });

  final String speciality;

  @override
  List<Object?> get props => [
        speciality,
      ];
}

final class BookingEnterSymptomEvent extends BookingEvent {
  const BookingEnterSymptomEvent({
    required this.symptom,
  });

  final String symptom;

  @override
  List<Object?> get props => [
        symptom,
      ];
}

final class BookingConfirmEvent extends BookingEvent {
  const BookingConfirmEvent();
}

final class BookingResetEvent extends BookingEvent {
  const BookingResetEvent();
}

final class BookingBackToInitialEvent extends BookingEvent {
  const BookingBackToInitialEvent();
}