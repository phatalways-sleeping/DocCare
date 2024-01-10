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
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  List<Object?> get props => [data];
}

final class ReceptionistAbsentLoadingState extends ReceptionistAbsentState {
  const ReceptionistAbsentLoadingState({
    required this.data,
  });

  factory ReceptionistAbsentLoadingState.fromState({
    required ReceptionistAbsentViewState state,
  }) =>
      ReceptionistAbsentLoadingState(
        data: state.data,
      );

  final Map<String, dynamic> data;

  @override
  List<Object?> get props => [data];
}

final class ReceptionistAbsentSuccessState extends ReceptionistAbsentState {
  const ReceptionistAbsentSuccessState({
    required this.data,
  });

  factory ReceptionistAbsentSuccessState.fromState({
    required ReceptionistAbsentLoadingState state,
  }) =>
      ReceptionistAbsentSuccessState(
        data: state.data,
      );

  final Map<String, dynamic> data;

  @override
  List<Object?> get props => [data];
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