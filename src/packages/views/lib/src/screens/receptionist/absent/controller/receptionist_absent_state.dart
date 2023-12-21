// ignore_for_file: public_member_api_docs

part of 'receptionist_absent_bloc.dart';

@immutable
sealed class ReceptionistAbsentState extends Equatable {
  const ReceptionistAbsentState();

  @override
  List<Object?> get props => [];
}

final class ReceptionistAbsentInitial extends ReceptionistAbsentState {
  const ReceptionistAbsentInitial();
}

final class ReceptionistAbsentViewState extends ReceptionistAbsentState {
  const ReceptionistAbsentViewState({
    required this.doctorId,
    required this.date,
  });

  final String doctorId;
  final DateTime date;

  @override
  List<Object?> get props => [doctorId, date];
}

final class ReceptionistAbsentLoadingState extends ReceptionistAbsentState {
  const ReceptionistAbsentLoadingState({
    required this.doctorId,
    required this.date,
  });

  factory ReceptionistAbsentLoadingState.fromState({
    required ReceptionistAbsentViewState state,
  }) =>
      ReceptionistAbsentLoadingState(
        doctorId: state.doctorId,
        date: state.date,
      );

  final String doctorId;
  final DateTime date;

  @override
  List<Object?> get props => [doctorId, date];
}

final class ReceptionistAbsentSuccessState extends ReceptionistAbsentState {
  const ReceptionistAbsentSuccessState({
    required this.doctorId,
    required this.date,
  });

  factory ReceptionistAbsentSuccessState.fromState({
    required ReceptionistAbsentLoadingState state,
  }) =>
      ReceptionistAbsentSuccessState(
        doctorId: state.doctorId,
        date: state.date,
      );

  final String doctorId;
  final DateTime date;

  @override
  List<Object?> get props => [doctorId, date];
}

final class ReceptionistAbsentErrorState extends ReceptionistAbsentState {
  const ReceptionistAbsentErrorState({
    required this.errorMessage,
  });
  factory ReceptionistAbsentErrorState.from({
    required String errorMessage,
  }) =>
      ReceptionistAbsentErrorState(
        errorMessage: errorMessage,
      );

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}