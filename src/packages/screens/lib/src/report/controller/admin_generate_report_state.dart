// ignore_for_file: public_member_api_docs

part of 'admin_generate_report_bloc.dart';

@immutable
sealed class GenerateReportState extends Equatable {
  const GenerateReportState ({
    required this.fromMonth,
    required this.toMonth,
    required this.year,
  });

  final int fromMonth;

  final int toMonth;

  final int year;

  @override
  List<Object> get props => [
        fromMonth,
        toMonth,
        year,
      ];

  GenerateReportState copyWith({
    int? fromMonth,
    int? toMonth,
    int? year,
  });
}

final class GenerateReportInitial extends GenerateReportState {
  GenerateReportInitial.empty()
      : super(
          fromMonth: 0,
          toMonth: 0,
          year: 0,
        );

  const GenerateReportInitial.input({
    required super.fromMonth,
    required super.toMonth,
    required super.year,
  });

  @override
  GenerateReportState copyWith({
    int? fromMonth,
    int? toMonth,
    int? year,
  }) =>
      GenerateReportInitial.input(
        fromMonth: fromMonth ?? super.fromMonth,
        toMonth: toMonth ?? super.toMonth,
        year: year ?? super.year,
      );
}

final class GenerateReportLoading extends GenerateReportState {
  const GenerateReportLoading({
    required super.fromMonth,
    required super.toMonth,
    required super.year,
  });

  factory GenerateReportLoading.from(GenerateReportState state) => GenerateReportLoading(
        fromMonth: state.fromMonth,
        toMonth: state.toMonth,
        year: state.year,
      );

  GenerateReportState toggleBackToInitial() => GenerateReportInitial.input(
        fromMonth: fromMonth,
        toMonth: toMonth,
        year: year,

      );

  @override
  GenerateReportState copyWith({
    int? fromMonth,
    int? toMonth,
    int? year,
  }) =>
      GenerateReportLoading(
        fromMonth: fromMonth ?? super.fromMonth,
        toMonth: toMonth ?? super.toMonth,
        year: year ?? super.year,
      );
}

final class GenerateReportSuccess extends GenerateReportState {
  const GenerateReportSuccess({
    required super.fromMonth,
    required super.toMonth,
    required super.year,
  });

  factory GenerateReportSuccess.from(GenerateReportState state) => GenerateReportSuccess(
        fromMonth: state.fromMonth,
        toMonth: state.toMonth,
        year: state.year,
      );

  @override
  GenerateReportState copyWith({
    int? fromMonth,
    int? toMonth,
    int? year,
  }) =>
      GenerateReportSuccess(
        fromMonth: fromMonth ?? super.fromMonth,
        toMonth: toMonth ?? super.toMonth,
        year: year ?? super.year,
      );
}

final class GenerateReportFailure extends GenerateReportState {
  const GenerateReportFailure({
    required super.fromMonth,
    required super.toMonth,
    required super.year,
    required this.message,
  });

  factory GenerateReportFailure.from(GenerateReportState state, String message) =>
      GenerateReportFailure(
        fromMonth: state.fromMonth,
        toMonth: state.toMonth,
        year: state.year,
        message: message,
      );

  GenerateReportState toggleBackToInitial() => GenerateReportInitial.input(
        fromMonth: fromMonth,
        toMonth: toMonth,
        year: year,
      );

  final String message;

  @override
  GenerateReportState copyWith({
    int? fromMonth,
    int? toMonth,
    int? year,
  }) =>
      GenerateReportFailure(
        fromMonth: fromMonth ?? super.fromMonth,
        toMonth: toMonth ?? super.toMonth,
        year: year ?? super.year,
        message: message,
      );
}