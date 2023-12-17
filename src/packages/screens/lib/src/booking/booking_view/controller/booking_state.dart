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
  });

  final Map<String, dynamic> doctorData;
  final String symptom;
  final DateTime? dateSelected;
  final String? timeSelected;
  final String? remindMeBefore;

  @override
  List<Object?> get props => [
        doctorData,
        symptom,
        dateSelected,
        timeSelected,
        remindMeBefore,
      ];

  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
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
  });

  factory BookingInitial.fromState({
    required BookingState state,
  }) {
    return BookingInitial(
      doctorData: state.doctorData.isEmpty ? const {} : state.doctorData,
      symptom: state.symptom.isEmpty ? '' : state.symptom,
      dateSelected: state.dateSelected,
      timeSelected: state.timeSelected,
      remindMeBefore: state.remindMeBefore,
    );
  }

  @override
  BookingState copyWith({
    Map<String, dynamic>? doctorData,
    String? symptom,
    DateTime? dateSelected,
    String? timeSelected,
    String? remindMeBefore,
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
    );
  }
}
