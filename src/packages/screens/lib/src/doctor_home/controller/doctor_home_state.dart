
part of 'doctor_home_bloc.dart';

@immutable
sealed class DoctorHomeState extends Equatable {
  const DoctorHomeState({
    required this.customerID,
    //required this.customerName,
    required this.customerName,
  });

  final String customerID;
  final String customerName;

  @override
  List<Object?> get props => [
        customerID,
        customerName,
      ];

  DoctorHomeState copyWith({
    String? customerID,
    String? customerName,
  });
}

final class DoctorHomeViewState extends DoctorHomeState {
  const DoctorHomeViewState()
      : super(
          customerID: '',
          customerName: '',
        );

  factory DoctorHomeViewState.initial() {
    return const DoctorHomeViewState();
  }

  @override
  DoctorHomeState copyWith({
    String? customerID,
    String? customerName,
  }) {
    return const DoctorHomeViewState();
  }
}

final class DoctorScheduleViewState extends DoctorHomeState {
  const DoctorScheduleViewState({
    required super.customerID,
    required super.customerName,
  });
    
  factory DoctorScheduleViewState.fromState(
    DoctorHomeState state, {
    String? customerID,
  }) {
    return DoctorScheduleViewState(
      customerID: customerID ?? state.customerID,
      customerName: state.customerName,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? customerID,
    String? customerName,
  }) {
    return DoctorScheduleViewState(
      customerID: customerID ?? this.customerID,
      customerName: customerName ?? this.customerName,
    );
  }
}

final class DoctorHomeViewLoadingState extends DoctorHomeState {
  const DoctorHomeViewLoadingState({
    required super.customerID,
    required super.customerName,
  });

  factory DoctorHomeViewLoadingState.fromState(DoctorHomeState state) {
    return DoctorHomeViewLoadingState(
      customerID: state.customerID,
      customerName: state.customerName,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? customerID,
    String? customerName,
  }) {
    return DoctorHomeViewLoadingState(
      customerID: customerID ?? this.customerID,
      customerName: customerName ?? this.customerName,
    );
  }
}

final class DoctorScheduleViewLoadingState extends DoctorHomeState {
  const DoctorScheduleViewLoadingState({
    required super.customerID,
    required super.customerName,
  });

  factory DoctorScheduleViewLoadingState.fromState(DoctorHomeState state) {
    return DoctorScheduleViewLoadingState(
      customerID: state.customerID,
      customerName: state.customerName,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? customerID,
    String? customerName,
  }) {
    return DoctorScheduleViewLoadingState(
      customerID: customerID ?? this.customerID,
      customerName: customerName ?? this.customerName,
    );
  }
}

// final class IntakeViewState extends DoctorHomeState {
//   const IntakeViewState({
//     required super.customerID,
//     required super.customerName,
//   });

//   factory IntakeViewState.fromState(DoctorHomeState state) {
//     return IntakeViewState(
//       customerID: state.customerID,
//       customerName: state.customerName,
//     );
//   }

//   @override
//   DoctorHomeState copyWith({
//     String? customerID,
//     String? customerName,
//   }) {
//     return IntakeViewState(
//       customerID: customerID ?? this.customerID,
//       customerName: customerName ?? this.customerName,
//     );
//   }
// }

// final class IntakeViewRatingResultState extends DoctorHomeState {
//   const IntakeViewRatingResultState({
//     required super.customerID,
//     required super.customerName,
//     required this.success,
//   });

//   factory IntakeViewRatingResultState.fromState({
//     required DoctorHomeState state,
//     required bool success,
//   }) {
//     return IntakeViewRatingResultState(
//       customerID: state.customerID,
//       customerName: state.customerName,
//       success: success,
//     );
//   }

//   final bool success;

//   @override
//   DoctorHomeState copyWith({
//     String? customerID,
//     String? customerName,
//     bool? success,
//   }) {
//     return IntakeViewRatingResultState(
//       customerID: customerID ?? this.customerID,
//       customerName: customerName ?? this.customerName,
//       success: success ?? this.success,
//     );
//   }
// }