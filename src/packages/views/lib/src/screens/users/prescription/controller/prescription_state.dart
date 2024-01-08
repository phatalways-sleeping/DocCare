// ignore_for_file: public_member_api_docs

part of 'prescription_bloc.dart';

@immutable
sealed class PrescriptionState extends Equatable {
  const PrescriptionState({
    required this.prescriptionId,
    required this.medicineName,
  });

  final String prescriptionId;
  final String medicineName;

  @override
  List<Object?> get props => [
        prescriptionId,
        medicineName,
      ];

  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  });
}

final class PrescriptionViewState extends PrescriptionState {
  const PrescriptionViewState()
      : super(
          prescriptionId: '',
          medicineName: '',
        );

  factory PrescriptionViewState.initial() {
    return const PrescriptionViewState();
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return const PrescriptionViewState();
  }
}

final class PrescriptionEmptyState extends PrescriptionState {
  const PrescriptionEmptyState()
      : super(
          prescriptionId: '',
          medicineName: '',
        );

  factory PrescriptionEmptyState.fromState(PrescriptionState state) {
    return const PrescriptionEmptyState();
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return const PrescriptionEmptyState();
  }
}

final class PrescriptionBlankState extends PrescriptionState {
  const PrescriptionBlankState()
      : super(
          prescriptionId: '',
          medicineName: '',
        );

  factory PrescriptionBlankState.fromState(PrescriptionState state) {
    return const PrescriptionBlankState();
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return const PrescriptionBlankState();
  }
}

final class MedicinesViewState extends PrescriptionState {
  const MedicinesViewState({
    required super.prescriptionId,
    required super.medicineName,
  });

  factory MedicinesViewState.fromState(
    PrescriptionState state, {
    String? prescriptionId,
  }) {
    return MedicinesViewState(
      prescriptionId: prescriptionId ?? state.prescriptionId,
      medicineName: state.medicineName,
    );
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return MedicinesViewState(
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineName: medicineName ?? this.medicineName,
    );
  }
}

final class PrescriptionViewLoadingState extends PrescriptionState {
  const PrescriptionViewLoadingState({
    required super.prescriptionId,
    required super.medicineName,
  });

  factory PrescriptionViewLoadingState.fromState(PrescriptionState state) {
    return PrescriptionViewLoadingState(
      prescriptionId: state.prescriptionId,
      medicineName: state.medicineName,
    );
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return PrescriptionViewLoadingState(
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineName: medicineName ?? this.medicineName,
    );
  }
}

final class MedicinesViewLoadingState extends PrescriptionState {
  const MedicinesViewLoadingState({
    required super.prescriptionId,
    required super.medicineName,
  });

  factory MedicinesViewLoadingState.fromState(PrescriptionState state) {
    return MedicinesViewLoadingState(
      prescriptionId: state.prescriptionId,
      medicineName: state.medicineName,
    );
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return MedicinesViewLoadingState(
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineName: medicineName ?? this.medicineName,
    );
  }
}

final class IntakeViewState extends PrescriptionState {
  const IntakeViewState({
    required super.prescriptionId,
    required super.medicineName,
  });

  factory IntakeViewState.fromState(
    PrescriptionState state,
    String prescriptionId,
  ) {
    return IntakeViewState(
      prescriptionId: prescriptionId,
      medicineName: state.medicineName,
    );
  }

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
  }) {
    return IntakeViewState(
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineName: medicineName ?? this.medicineName,
    );
  }
}

final class IntakeViewRatingResultState extends PrescriptionState {
  const IntakeViewRatingResultState({
    required super.prescriptionId,
    required super.medicineName,
    required this.success,
  });

  factory IntakeViewRatingResultState.fromState({
    required PrescriptionState state,
    required bool success,
  }) {
    return IntakeViewRatingResultState(
      prescriptionId: state.prescriptionId,
      medicineName: state.medicineName,
      success: success,
    );
  }

  final bool success;

  @override
  PrescriptionState copyWith({
    String? prescriptionId,
    String? medicineName,
    bool? success,
  }) {
    return IntakeViewRatingResultState(
      prescriptionId: prescriptionId ?? this.prescriptionId,
      medicineName: medicineName ?? this.medicineName,
      success: success ?? this.success,
    );
  }
}
