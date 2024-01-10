// ignore_for_file: public_member_api_docs

part of 'booking_bloc.dart';

@immutable
sealed class BookingState extends Equatable {
  const BookingState({
    required this.doctorData,
    required this.symptom,
    this.dateSelected,
    this.timeSelected,
    this.remindMeBefore,
    this.speciality,
  });

  final Map<String, dynamic> doctorData;
  final String symptom;
  final DateTime? dateSelected;
  final String? timeSelected;
  final String? remindMeBefore;
  final String? speciality;

  @override
  List<Object?> get props => [
        doctorData,
        symptom,
        dateSelected,
        timeSelected,
        remindMeBefore,
        speciality,
      ];

  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
    String? speciality,
    bool cascadeRemindMeBefore = true,
    bool cascadeTimeSelected = true,
    bool cascadeDateSelected = true,
  });
}

final class BookingInitial extends BookingState {
  const BookingInitial({
    super.doctorData = const {},
    super.symptom = '',
    super.dateSelected,
    super.timeSelected,
    super.remindMeBefore,
    super.speciality,
  });

  factory BookingInitial.fromState({
    required BookingState state,
  }) {
    return BookingInitial(
      doctorData: state.doctorData.isEmpty ? const {} : state.doctorData,
      symptom: state.symptom,
      dateSelected: state.dateSelected,
      timeSelected: state.timeSelected,
      remindMeBefore: state.remindMeBefore,
      speciality: state.speciality,
    );
  }

  @override
  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
    String? speciality,
    bool cascadeRemindMeBefore = true,
    bool cascadeTimeSelected = true,
    bool cascadeDateSelected = true,
  }) {
    return BookingInitial(
      doctorData: doctorData ?? this.doctorData,
      symptom: symptom ?? this.symptom,
      dateSelected: !cascadeDateSelected
          ? dateSelected
          : dateSelected ?? this.dateSelected,
      timeSelected: !cascadeTimeSelected
          ? timeSelected
          : timeSelected ?? this.timeSelected,
      remindMeBefore: !cascadeRemindMeBefore
          ? remindMeBefore
          : remindMeBefore ?? this.remindMeBefore,
      speciality: speciality ?? this.speciality,
    );
  }
}

final class BookingLoadingRequest extends BookingState {
  const BookingLoadingRequest({
    super.doctorData = const {},
    super.symptom = '',
    super.dateSelected,
    super.timeSelected,
    super.remindMeBefore,
    super.speciality,
  }) : assert(
          doctorData.length > 0 || speciality != null,
          'doctorData and speciality cannot be null at the same time',
        );

  factory BookingLoadingRequest.fromState({
    required BookingState state,
  }) {
    return BookingLoadingRequest(
      doctorData: state.doctorData.isEmpty ? const {} : state.doctorData,
      symptom: state.symptom,
      dateSelected: state.dateSelected,
      timeSelected: state.timeSelected,
      remindMeBefore: state.remindMeBefore,
      speciality: state.speciality,
    );
  }

  @override
  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
    String? speciality,
    bool cascadeRemindMeBefore = true,
    bool cascadeTimeSelected = true,
    bool cascadeDateSelected = true,
  }) {
    return BookingLoadingRequest(
      doctorData: doctorData ?? this.doctorData,
      symptom: symptom ?? this.symptom,
      dateSelected: !cascadeDateSelected
          ? dateSelected
          : dateSelected ?? this.dateSelected,
      timeSelected: !cascadeTimeSelected
          ? timeSelected
          : timeSelected ?? this.timeSelected,
      remindMeBefore: !cascadeRemindMeBefore
          ? remindMeBefore
          : remindMeBefore ?? this.remindMeBefore,
      speciality: speciality ?? this.speciality,
    );
  }
}

final class BookingSuccess extends BookingState {
  const BookingSuccess({
    super.doctorData = const {},
    super.dateSelected,
    super.timeSelected,
  }) : super(
          symptom: '',
          remindMeBefore: null,
          speciality: null,
        );

  @override
  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
    String? speciality,
    bool cascadeRemindMeBefore = true,
    bool cascadeTimeSelected = true,
    bool cascadeDateSelected = true,
  }) {
    return BookingSuccess(
      doctorData: doctorData ?? const {},
      dateSelected: dateSelected ?? this.dateSelected,
      timeSelected: timeSelected ?? this.timeSelected,
    );
  }
}

final class BookingFailure extends BookingState {
  const BookingFailure({
    required super.doctorData,
    required this.error,
  }) : super(
          symptom: '',
          dateSelected: null,
          timeSelected: null,
          remindMeBefore: null,
          speciality: null,
        );

  factory BookingFailure.from({
    required Map<String, dynamic> doctorData,
    required String error,
  }) {
    return BookingFailure(
      doctorData: doctorData,
      error: error,
    );
  }

  final String error;

  @override
  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
    String? speciality,
    bool cascadeRemindMeBefore = true,
    bool cascadeTimeSelected = true,
    bool cascadeDateSelected = true,
  }) {
    return BookingFailure(
      doctorData: doctorData ?? this.doctorData,
      error: error,
    );
  }
}
