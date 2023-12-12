part of 'intake_bloc.dart';

@immutable
sealed class IntakeEvent extends Equatable {
  const IntakeEvent();

  @override
  List<Object?> get props => [];
}

final class IntakeInitialEvent extends IntakeEvent {
  const IntakeInitialEvent();

  @override
  List<Object?> get props => [];
}

final class IntakeTapEvent extends IntakeEvent {
  const IntakeTapEvent();

  @override
  List<Object?> get props => [];
}
