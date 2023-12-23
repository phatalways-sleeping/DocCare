
part of 'doctor_home_bloc.dart';

@immutable
sealed class DoctorHomeEvent extends Equatable {
  const DoctorHomeEvent();

  @override
  List<Object?> get props => [];
}

final class DoctorHomeResetEvent extends DoctorHomeEvent {
  const DoctorHomeResetEvent();

  @override
  List<Object?> get props => [];
}
final class DoctorHomeOpenDoctorScheduleViewEvent extends DoctorHomeEvent {
  const DoctorHomeOpenDoctorScheduleViewEvent({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object?> get props => [date];
}

final class DoctorHomeOpenCancelAppointmentViewEvent extends DoctorHomeEvent {
  const DoctorHomeOpenCancelAppointmentViewEvent({
    required this.customerID,
    required this.doctorID,
    required this.period,
    required this.date,

  });

  final String customerID;
  final String doctorID;
  final int period;
  final DateTime date;


  @override
  List<Object?> get props => [customerID,doctorID,period,date];
}
// final class OpenIntakeViewEvent extends DoctorHomeEvent {
//   const OpenIntakeViewEvent({
//     required this.customerID,
//   });
//   final String customerID;

//   @override
//   List<Object?> get props => [customerID];
// }

// final class IntakeRatingEvent extends DoctorHomeEvent {
//   const IntakeRatingEvent({
//     required this.rating,
//   });

//   final int rating;

//   @override
//   List<Object?> get props => [rating];
// }