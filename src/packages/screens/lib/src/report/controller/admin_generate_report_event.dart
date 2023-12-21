// ignore_for_file: public_member_api_docs

part of 'admin_generate_report_bloc.dart';

@immutable
sealed class GenerateReportEvent extends Equatable {
  const GenerateReportEvent();

  @override
  List<Object> get props => [];
}

final class FromMonthInputEvent extends GenerateReportEvent {
  const FromMonthInputEvent(this.fromMonth);

  final int fromMonth;

  @override
  List<Object> get props => [fromMonth];
}

final class ToMonthInputEvent extends GenerateReportEvent {
  const ToMonthInputEvent(this.toMonth);

  final int toMonth;

  @override
  List<Object> get props => [toMonth];
}

final class YearInputEvent extends GenerateReportEvent {
  const YearInputEvent(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class GenerateReportButtonPressedEvent extends GenerateReportEvent {
  const GenerateReportButtonPressedEvent();
}
