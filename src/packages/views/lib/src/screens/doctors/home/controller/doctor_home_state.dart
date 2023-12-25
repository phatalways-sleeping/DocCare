
part of 'doctor_home_bloc.dart';

@immutable
sealed class DoctorHomeState extends Equatable {
  const DoctorHomeState({
    required this.doctorName,
    required this.doctorAvatarUrl,
    required this.appointments,
    required this.upcomingAppointmentIndex,
    required this.upcomingCustomerName,
    required this.appointmentInDate,
    required this.selectedDate,
  });

  final String doctorName;
  final String doctorAvatarUrl;
  final List<dynamic> appointments;
  final int upcomingAppointmentIndex;
  final String upcomingCustomerName;
  final Map<String,List<dynamic>> appointmentInDate;
  final DateTime selectedDate;

  @override
  List<Object?> get props => [
        
        doctorName,
        doctorAvatarUrl,
        appointments,
        upcomingAppointmentIndex,
        upcomingCustomerName,
        appointmentInDate,
        selectedDate,
      ];

  DoctorHomeState copyWith({
    String? doctorName,
    String? doctorAvatarUrl,
    List<dynamic>? appointments,
    int? upcomingAppointmentIndex,
    String? upcomingCustomerName,
    Map<String,List<dynamic>>? appointmentInDate,
    DateTime? selectedDate,
  });
}

final class DoctorHomeInitial extends DoctorHomeState {
  const DoctorHomeInitial({
    required super.doctorName,
    required super.doctorAvatarUrl,
    required super.appointments,
    required super.upcomingAppointmentIndex,
    required super.upcomingCustomerName,
    required super.appointmentInDate,
    required super.selectedDate,
  });

  DoctorHomeInitial.empty()
      : super(
          doctorName: '',
          doctorAvatarUrl: '',
          appointments: [],
          upcomingAppointmentIndex: -1,
          upcomingCustomerName: '',
          appointmentInDate: {},
          selectedDate: DateTime.now(),
        );

  factory DoctorHomeInitial.from(DoctorHomeState state) =>
      DoctorHomeInitial(
        doctorName: state.doctorName,
        doctorAvatarUrl: state.doctorAvatarUrl,
        appointments: state.appointments,
        upcomingAppointmentIndex: state.upcomingAppointmentIndex,
        upcomingCustomerName: state.upcomingCustomerName,
        appointmentInDate: state.appointmentInDate,
        selectedDate: state.selectedDate,
      );

  const DoctorHomeInitial.input({
    required String doctorName,
    required String doctorAvatarUrl,
    required List<dynamic> appointments,
    required int upcomingAppointmentIndex,
    required String upcomingCustomerName,
    required Map<String,List<dynamic>> appointmentInDate,
    required DateTime selectedDate,
  }) : super(
           
          doctorName: doctorName,
          doctorAvatarUrl: doctorAvatarUrl,
          appointments: appointments,
          upcomingAppointmentIndex: upcomingAppointmentIndex,
          upcomingCustomerName: upcomingCustomerName,
          appointmentInDate: appointmentInDate,
          selectedDate: selectedDate,
        );

  @override
  DoctorHomeState copyWith({
    String? doctorName,
    String? doctorAvatarUrl,
    List<dynamic>? appointments,
    int? upcomingAppointmentIndex,
    String? upcomingCustomerName,
    Map<String,List<dynamic>>? appointmentInDate,
    DateTime? selectedDate,
  }) {
    return DoctorHomeInitial.input(
      doctorName: doctorName ?? super.doctorName,
      doctorAvatarUrl: doctorAvatarUrl ?? super.doctorAvatarUrl,
      appointments: appointments ?? super.appointments,
      upcomingAppointmentIndex:
          upcomingAppointmentIndex ?? super.upcomingAppointmentIndex,
      upcomingCustomerName: upcomingCustomerName ?? super.upcomingCustomerName,
      appointmentInDate: appointmentInDate ?? super.appointmentInDate,
      selectedDate: selectedDate ?? super.selectedDate,
    );
  }
}

final class DoctorScheduleViewState extends DoctorHomeState {
  const DoctorScheduleViewState({
    required super.doctorName,
    required super.doctorAvatarUrl,
    required super.appointments,
    required super.upcomingAppointmentIndex,
    required super.upcomingCustomerName,
    required super.appointmentInDate,
    required super.selectedDate,
  });
    
  factory DoctorScheduleViewState.fromState(DoctorHomeState state) {
    return DoctorScheduleViewState(
      doctorName: state.doctorName,
      doctorAvatarUrl: state.doctorAvatarUrl,
      appointments: state.appointments,
      upcomingAppointmentIndex: state.upcomingAppointmentIndex,
      upcomingCustomerName: state.upcomingCustomerName,
      appointmentInDate: state.appointmentInDate,
      selectedDate: state.selectedDate,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? doctorName,
    String? doctorAvatarUrl,
    List<dynamic>? appointments,
    int? upcomingAppointmentIndex,
    String? upcomingCustomerName,
    Map<String,List<dynamic>>? appointmentInDate,
    DateTime? selectedDate,
  }) {
    return DoctorScheduleViewState(
      doctorName: doctorName ?? this.doctorName,
      doctorAvatarUrl: doctorAvatarUrl ?? this.doctorAvatarUrl,
      appointments: appointments ?? this.appointments,
      upcomingAppointmentIndex:
          upcomingAppointmentIndex ?? this.upcomingAppointmentIndex,
      upcomingCustomerName: upcomingCustomerName ?? this.upcomingCustomerName,
      appointmentInDate: appointmentInDate ?? this.appointmentInDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final class DoctorHomeViewLoadingState extends DoctorHomeState {
  const DoctorHomeViewLoadingState({
    required super.doctorName,
    required super.doctorAvatarUrl,
    required super.appointments,
    required super.upcomingAppointmentIndex,
    required super.upcomingCustomerName,
    required super.appointmentInDate,
    required super.selectedDate,
  });

  factory DoctorHomeViewLoadingState.fromState(DoctorHomeState state) {
    return DoctorHomeViewLoadingState(
      doctorName: state.doctorName,
      doctorAvatarUrl: state.doctorAvatarUrl,
      appointments: state.appointments,
      upcomingAppointmentIndex: state.upcomingAppointmentIndex,
      upcomingCustomerName: state.upcomingCustomerName,
      appointmentInDate: state.appointmentInDate,
      selectedDate: state.selectedDate,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? doctorName,
    String? doctorAvatarUrl,
    List<dynamic>? appointments,
    int? upcomingAppointmentIndex,
    String? upcomingCustomerName,
    Map<String,List<dynamic>>? appointmentInDate,
    DateTime? selectedDate,
  }) {
    return DoctorHomeViewLoadingState(
      doctorName: doctorName ?? this.doctorName,
      doctorAvatarUrl: doctorAvatarUrl ?? this.doctorAvatarUrl,
      appointments: appointments ?? this.appointments,
      upcomingAppointmentIndex:
          upcomingAppointmentIndex ?? this.upcomingAppointmentIndex,
      upcomingCustomerName: upcomingCustomerName ?? this.upcomingCustomerName,
      appointmentInDate: appointmentInDate ?? this.appointmentInDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final class DoctorScheduleViewLoadingState extends DoctorHomeState {
  const DoctorScheduleViewLoadingState({
    required super.doctorName,
    required super.doctorAvatarUrl,
    required super.appointments,
    required super.upcomingAppointmentIndex,
    required super.upcomingCustomerName,
    required super.appointmentInDate,
    required super.selectedDate,
  });

  factory DoctorScheduleViewLoadingState.fromState(DoctorHomeState state) {
    return DoctorScheduleViewLoadingState(
      doctorName: state.doctorName,
      doctorAvatarUrl: state.doctorAvatarUrl,
      appointments: state.appointments,
      upcomingAppointmentIndex: state.upcomingAppointmentIndex,
      upcomingCustomerName: state.upcomingCustomerName,
      appointmentInDate: state.appointmentInDate,
      selectedDate: state.selectedDate,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? doctorName,
    String? doctorAvatarUrl,
    List<dynamic>? appointments,
    int? upcomingAppointmentIndex,
    String? upcomingCustomerName,
    Map<String,List<dynamic>>? appointmentInDate,
    DateTime? selectedDate,
  }) {
    return DoctorScheduleViewLoadingState(
      doctorName: doctorName ?? this.doctorName,
      doctorAvatarUrl: doctorAvatarUrl ?? this.doctorAvatarUrl,
      appointments: appointments ?? this.appointments,
      upcomingAppointmentIndex:
          upcomingAppointmentIndex ?? this.upcomingAppointmentIndex,
      upcomingCustomerName: upcomingCustomerName ?? this.upcomingCustomerName,
      appointmentInDate: appointmentInDate ?? this.appointmentInDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final class DoctorHomeLoadedSuccess extends DoctorHomeState {
  const DoctorHomeLoadedSuccess({
    required super.doctorName,
    required super.doctorAvatarUrl,
    required super.appointments,
    required super.upcomingAppointmentIndex,
    required super.upcomingCustomerName,
    required super.appointmentInDate,
    required super.selectedDate,
  });

  factory DoctorHomeLoadedSuccess.fromState(DoctorHomeState state) {
    return DoctorHomeLoadedSuccess(
      doctorName: state.doctorName,
      doctorAvatarUrl: state.doctorAvatarUrl,
      appointments: state.appointments,
      upcomingAppointmentIndex: state.upcomingAppointmentIndex,
      upcomingCustomerName: state.upcomingCustomerName,
      appointmentInDate: state.appointmentInDate,
      selectedDate: state.selectedDate,
    );
  }

  @override
  DoctorHomeState copyWith({
    String? doctorName,
    String? doctorAvatarUrl,
    List<dynamic>? appointments,
    int? upcomingAppointmentIndex,
    String? upcomingCustomerName,
    Map<String,List<dynamic>>? appointmentInDate,
    DateTime? selectedDate,
  }) {
    return DoctorHomeLoadedSuccess(
      doctorName: doctorName ?? this.doctorName,
      doctorAvatarUrl: doctorAvatarUrl ?? this.doctorAvatarUrl,
      appointments: appointments ?? this.appointments,
      upcomingAppointmentIndex:
          upcomingAppointmentIndex ?? this.upcomingAppointmentIndex,
      upcomingCustomerName: upcomingCustomerName ?? this.upcomingCustomerName,
      appointmentInDate: appointmentInDate ?? this.appointmentInDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
