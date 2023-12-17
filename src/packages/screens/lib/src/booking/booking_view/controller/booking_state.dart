// ignore_for_file: public_member_api_docs

part of 'booking_bloc.dart';

@immutable
sealed class BookingState extends Equatable {
  const BookingState({
    required this.doctorData,
  });

  final Map<String, dynamic> doctorData;

  @override
  List<Object?> get props => [
        doctorData,
      ];

  BookingState copyWith({
    Map<String, dynamic>? doctorData,
  });
}

final class BookingInitial extends BookingState {
  const BookingInitial({
    super.doctorData = const {},
  });

  factory BookingInitial.fromState({
    required BookingState state,
  }) {
    return BookingInitial(
      doctorData: state.doctorData.isEmpty ? const {} : state.doctorData,
    );
  }

  @override
  BookingInitial copyWith({
    Map<String, dynamic>? doctorData,
  }) {
    return BookingInitial(
      doctorData: doctorData ?? this.doctorData,
    );
  }
}
