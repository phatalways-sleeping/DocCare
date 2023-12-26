// ignore_for_file: public_member_api_docs

part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState({
    required this.name,
    required this.heartRate,
    required this.bloodPressure,
    required this.cholesterol,
    required this.bloodSugar,
    required this.appointments,
    required this.oldBloodPressure,
    required this.oldBloodSugar,
    required this.oldCholesterol,
    required this.oldHeartRate,
    required this.currentPage,
  });

  final String name;
  final String heartRate;
  final String bloodPressure;
  final String cholesterol;
  final String bloodSugar;
  final String oldBloodPressure;
  final String oldBloodSugar;
  final String oldCholesterol;
  final String oldHeartRate;
  final int currentPage;

  /// Map of appointment date to list of appointment details
  /// e.g. { 'Cardiology Consultation': ['10:00 AM'] }
  final Map<String, List<String>> appointments;

  @override
  List<Object?> get props => [
        name,
        heartRate,
        bloodPressure,
        cholesterol,
        bloodSugar,
        oldBloodPressure,
        oldBloodSugar,
        oldCholesterol,
        oldHeartRate,
        appointments,
        currentPage,
      ];

  HomeState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? cholesterol,
    String? bloodSugar,
    String? oldBloodPressure,
    String? oldBloodSugar,
    String? oldCholesterol,
    String? oldHeartRate,
    Map<String, List<String>>? appointments,
    int? currentPage,
  });
}

final class HomeInitial extends HomeState {
  const HomeInitial.input({
    required super.name,
    required super.heartRate,
    required super.bloodPressure,
    required super.cholesterol,
    required super.bloodSugar,
    required super.oldBloodPressure,
    required super.oldBloodSugar,
    required super.oldCholesterol,
    required super.oldHeartRate,
    required super.appointments,
    required super.currentPage,
  });
  const HomeInitial({
    required super.name,
    required super.heartRate,
    required super.bloodPressure,
    required super.cholesterol,
    required super.bloodSugar,
    required super.oldBloodPressure,
    required super.oldBloodSugar,
    required super.oldCholesterol,
    required super.oldHeartRate,
    required super.appointments,
    required super.currentPage,
  });

  const HomeInitial.empty()
      : super(
          bloodPressure: '',
          bloodSugar: '',
          cholesterol: '',
          heartRate: '',
          name: '',
          oldBloodPressure: '',
          oldBloodSugar: '',
          oldCholesterol: '',
          oldHeartRate: '',
          appointments: const {},
          currentPage: 0,
        );

  factory HomeInitial.from(HomeState state) => HomeInitial(
        name: state.name,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        cholesterol: state.cholesterol,
        bloodSugar: state.bloodSugar,
        appointments: state.appointments,
        oldBloodPressure: state.oldBloodPressure,
        oldBloodSugar: state.oldBloodSugar,
        oldCholesterol: state.oldCholesterol,
        oldHeartRate: state.oldHeartRate,
        currentPage: state.currentPage,
      );

  @override
  HomeState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? cholesterol,
    String? bloodSugar,
    String? oldBloodPressure,
    String? oldBloodSugar,
    String? oldCholesterol,
    String? oldHeartRate,
    Map<String, List<String>>? appointments,
    int? currentPage,
  }) {
    return HomeInitial(
      name: name ?? super.name,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      cholesterol: cholesterol ?? super.cholesterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      oldBloodPressure: oldBloodPressure ?? super.oldBloodPressure,
      oldBloodSugar: oldBloodPressure ?? super.oldBloodSugar,
      oldCholesterol: oldCholesterol ?? super.oldCholesterol,
      oldHeartRate: oldHeartRate ?? super.oldHeartRate,
      appointments: appointments ?? super.appointments,
      currentPage: currentPage ?? super.currentPage,
    );
  }
}

final class HomeLoading extends HomeState {
  const HomeLoading({
    required super.name,
    required super.heartRate,
    required super.bloodPressure,
    required super.cholesterol,
    required super.bloodSugar,
    required super.oldBloodPressure,
    required super.oldBloodSugar,
    required super.oldCholesterol,
    required super.oldHeartRate,
    required super.appointments,
    required super.currentPage,
  });

  factory HomeLoading.from(HomeState state) => HomeLoading(
        name: state.name,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        cholesterol: state.cholesterol,
        bloodSugar: state.bloodSugar,
        oldBloodPressure: state.oldBloodPressure,
        oldBloodSugar: state.oldBloodSugar,
        oldCholesterol: state.oldCholesterol,
        oldHeartRate: state.oldHeartRate,
        appointments: state.appointments,
        currentPage: state.currentPage,
      );

  const HomeLoading.input({
    required super.name,
    required super.heartRate,
    required super.bloodPressure,
    required super.cholesterol,
    required super.bloodSugar,
    required super.oldBloodPressure,
    required super.oldBloodSugar,
    required super.oldCholesterol,
    required super.oldHeartRate,
    required super.appointments,
    required super.currentPage,
  });

  @override
  HomeState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? cholesterol,
    String? bloodSugar,
    String? oldBloodPressure,
    String? oldBloodSugar,
    String? oldCholesterol,
    String? oldHeartRate,
    Map<String, List<String>>? appointments,
    int? currentPage,
  }) {
    return HomeLoading(
      name: name ?? super.name,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      cholesterol: cholesterol ?? super.cholesterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      oldBloodPressure: oldBloodPressure ?? super.oldBloodPressure,
      oldBloodSugar: oldBloodPressure ?? super.oldBloodSugar,
      oldCholesterol: oldCholesterol ?? super.oldCholesterol,
      oldHeartRate: oldHeartRate ?? super.oldHeartRate,
      appointments: appointments ?? super.appointments,
      currentPage: currentPage ?? super.currentPage,
    );
  }
}

final class HomeSuccess extends HomeState {
  const HomeSuccess({
    required super.name,
    required super.heartRate,
    required super.bloodPressure,
    required super.cholesterol,
    required super.bloodSugar,
    required super.oldBloodPressure,
    required super.oldBloodSugar,
    required super.oldCholesterol,
    required super.oldHeartRate,
    required super.appointments,
    required super.currentPage,
  });

  factory HomeSuccess.from(HomeState state) => HomeSuccess(
        name: state.name,
        heartRate: state.heartRate,
        bloodPressure: state.bloodPressure,
        cholesterol: state.cholesterol,
        bloodSugar: state.bloodSugar,
        oldBloodPressure: state.oldBloodPressure,
        oldBloodSugar: state.oldBloodSugar,
        oldCholesterol: state.oldCholesterol,
        oldHeartRate: state.oldHeartRate,
        appointments: state.appointments,
        currentPage: state.currentPage,
      );

  const HomeSuccess.input({
    required super.name,
    required super.heartRate,
    required super.bloodPressure,
    required super.cholesterol,
    required super.bloodSugar,
    required super.oldBloodPressure,
    required super.oldBloodSugar,
    required super.oldCholesterol,
    required super.oldHeartRate,
    required super.appointments,
    required super.currentPage,
  });

  @override
  HomeState copyWith({
    String? name,
    String? heartRate,
    String? bloodPressure,
    String? cholesterol,
    String? bloodSugar,
    String? oldBloodPressure,
    String? oldBloodSugar,
    String? oldCholesterol,
    String? oldHeartRate,
    Map<String, List<String>>? appointments,
    int? currentPage,
  }) {
    return HomeSuccess(
      name: name ?? super.name,
      heartRate: heartRate ?? super.heartRate,
      bloodPressure: bloodPressure ?? super.bloodPressure,
      cholesterol: cholesterol ?? super.cholesterol,
      bloodSugar: bloodSugar ?? super.bloodSugar,
      oldBloodPressure: oldBloodPressure ?? super.oldBloodPressure,
      oldBloodSugar: oldBloodPressure ?? super.oldBloodSugar,
      oldCholesterol: oldCholesterol ?? super.oldCholesterol,
      oldHeartRate: oldHeartRate ?? super.oldHeartRate,
      appointments: appointments ?? super.appointments,
      currentPage: currentPage ?? super.currentPage,
    );
  }
}
