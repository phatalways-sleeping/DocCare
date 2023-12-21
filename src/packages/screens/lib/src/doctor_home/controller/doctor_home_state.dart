part of 'doctor_home_bloc.dart';

@immutable
sealed class DoctorHomeState extends Equatable {
  const DoctorHomeState({


      // final customerName = <String>[];
      // final period = <int>[];
      // final date = <DateTime>[];
      // final customerComment = <String?>[];
      // final currentDay = DateTime.now();

    required this.customerName,
    required this.period,
    required this.date,
    required this.customerComment,
    required this.currentDay,
  });

  final List<String> customerName;
  final List<int?> period;
  final List<DateTime> date;
  final List<String?> customerComment;
  final DateTime currentDay;

  @override
  List<Object?> get props => [
        customerName,
        period,
        date,
        customerComment,
        currentDay,
      ];

  DoctorHomeState copyWith({
    List<String>? customerName,
    List<int?>? period,
    List<DateTime>? date,
    List<String?>? customerComment,
    DateTime? currentDay,
  });
}

final class DoctorHomeInitial extends DoctorHomeState {
  DoctorHomeInitial.empty()
      : super(
          customerName: [],
          period: [],
          date: [],
          customerComment: [],
          currentDay: DateTime.now(),
        );

  const DoctorHomeInitial.input({
    required super.customerName,
    required super.period,
    required super.date,
    required super.customerComment,
    required super.currentDay,
  });

  @override
  DoctorHomeState copyWith({
    List<String>? customerName,
    List<int?>? period,
    List<DateTime>? date,
    List<String?>? customerComment,
    DateTime? currentDay,
  }) =>
      DoctorHomeInitial.input(
        customerName: customerName ?? super.customerName,
        period: period ?? super.period,
        date: date ?? super.date,
        customerComment: customerComment ?? super.customerComment,
        currentDay: currentDay ?? super.currentDay,
      );
}

final class DoctorHomeLoading extends DoctorHomeState {
  const DoctorHomeLoading({
    required super.customerName,
    required super.period,
    required super.date,
    required super.customerComment,
    required super.currentDay,
  });

  @override
  DoctorHomeState copyWith({
    List<String>? customerName,
    List<int?>? period,
    List<DateTime>? date,
    List<String?>? customerComment,
    DateTime? currentDay,
  }) =>
      DoctorHomeLoading(
        customerName: customerName ?? super.customerName,
        period: period ?? super.period,
        date: date ?? super.date,
        customerComment: customerComment ?? super.customerComment,
        currentDay: currentDay ?? super.currentDay,
      );

  DoctorHomeInitial toggleBackToInitial() => DoctorHomeInitial.input(
        customerName: customerName,
        period: period,
        date: date,
        customerComment: customerComment,
        currentDay: currentDay,
      );
}

final class DoctorScheduleInitial extends DoctorHomeState {
  const DoctorScheduleInitial({
    required super.customerName,
    required super.period,
    required super.date,
    required super.customerComment,
    required super.currentDay,
    // required this.medicineName,
    // required this.quantity,
    // required this.toBeTaken,
    // required this.timeOfTheDay,
    // required this.current,
    // required this.clickedIndex,
  });

  // final List<String> medicineName;
  // final List<int?> quantity;
  // final List<int?> toBeTaken;
  // final List<String?> timeOfTheDay;
  // final String current;
  // final int clickedIndex;

  @override
  List<Object?> get props => [
        customerName,
        period,
        date,
        customerComment,
        currentDay,
        // medicineName,
        // quantity,
        // toBeTaken,
        // timeOfTheDay,
        // current,
        // clickedIndex,
      ];

  @override
  DoctorHomeState copyWith({
    List<String>? customerName,
    List<int?>? period,
    List<DateTime>? date,
    List<String?>? customerComment,
    DateTime? currentDay,
  }) {
    return DoctorScheduleInitial(
      customerName: customerName ?? super.customerName,
      period: period ?? super.period,
      date: date ?? super.date,
      customerComment: customerComment ?? super.customerComment,
      currentDay: currentDay ?? super.currentDay,
      // medicineName: medicineName,
      // quantity: quantity,
      // toBeTaken: toBeTaken,
      // timeOfTheDay: timeOfTheDay,
      // current: current,
      // clickedIndex: clickedIndex,
    );
  }
}