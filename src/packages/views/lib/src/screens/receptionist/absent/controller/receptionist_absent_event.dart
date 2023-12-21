// ignore_for_file: public_member_api_docs

part of 'receptionist_absent_bloc.dart';

@immutable
sealed class ReceptionistAbsentEvent extends Equatable {
  const ReceptionistAbsentEvent();

  @override
  List<Object?> get props => [];
}

final class ReceptionistAbsentResetEvent extends ReceptionistAbsentEvent {
  const ReceptionistAbsentResetEvent();
}

final class ReceptionistAbsentViewEvent extends ReceptionistAbsentEvent {
  const ReceptionistAbsentViewEvent({
    required this.doctorId,
    required this.date,
  });

  final String doctorId;
  final DateTime date;

  @override
  List<Object?> get props => [doctorId, date];
}

final class ReceptionistAbsentResponseEvent extends ReceptionistAbsentEvent {
  const ReceptionistAbsentResponseEvent({
    required this.approved,
  });

  final bool approved;

  @override
  List<Object?> get props => [approved];
}