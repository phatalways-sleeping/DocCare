
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
    required this.appointment,}
  );
  final dynamic appointment;
  @override
  List<Object?> get props => [appointment];
}
final class DoctorHomeLoadEvent extends DoctorHomeEvent {
  const DoctorHomeLoadEvent();
}
