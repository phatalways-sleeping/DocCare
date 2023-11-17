import 'package:flutter/widgets.dart';

/// [DialogType] is the enum class for dialog type.
enum DialogType {
  /// [confirmSchedulingAppointment] is the enum for 
  /// confirm scheduling appointment dialog type.
  confirmSchedulingAppointment,
  /// [successfullySchedulingAppointment] is the enum for
  /// successfully scheduling appointment dialog type.
  successfullySchedulingAppointment,
  /// [failedSchedulingAppointment] is the enum for
  /// failed scheduling appointment dialog type.
  failedSchedulingAppointment,
}

/// [DialogBuilder] is the interface for dialog state
/// that is not [DismissedDialogState].
abstract interface class DialogBuilder {
  /// [show] is the method to show the dialog.
  Widget show(BuildContext context);
}

/// {@template dialog_state}
/// [DialogState] is the abstract class for all dialog states.
@immutable
sealed class DialogState {
  /// Constructor for [DialogState].
  const DialogState();
}

/// [DismissedDialogState] is the class for dismissed dialog state.
class DismissedDialogState extends DialogState {
  /// Constructor for [DismissedDialogState].
  const DismissedDialogState();
}

/// [ConfirmSchedulingAppointmentDialogState] is the class for
/// confirm scheduling appointment dialog state.
class ConfirmSchedulingAppointmentDialogState extends DialogState
    implements DialogBuilder {
  /// Constructor for [ConfirmSchedulingAppointmentDialogState].
  const ConfirmSchedulingAppointmentDialogState();

  @override
  Widget show(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

/// [SuccessfullySchedulingAppointmentDialogState] is the class for
/// successfully scheduling appointment dialog state.
class SuccessfullySchedulingAppointmentDialogState extends DialogState
    implements DialogBuilder {
  /// Constructor for [SuccessfullySchedulingAppointmentDialogState].
  const SuccessfullySchedulingAppointmentDialogState();

  @override
  Widget show(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

/// [FailedSchedulingAppointmentDialogState] is the class for
/// failed scheduling appointment dialog state.
class FailedSchedulingAppointmentDialogState extends DialogState
    implements DialogBuilder {
  /// Constructor for [FailedSchedulingAppointmentDialogState].
  const FailedSchedulingAppointmentDialogState();

  @override
  Widget show(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
