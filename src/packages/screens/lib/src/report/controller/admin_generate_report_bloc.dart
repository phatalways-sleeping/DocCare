// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:screens/src/report/generate_pdf_service.dart';
import 'package:auth_api/auth_api.dart' show AuthException;

import 'package:utility/utility.dart'
    show NotificationManagerService, NotificationType;

part 'admin_generate_report_event.dart';

part 'admin_generate_report_state.dart';

class GenerateReportBloc
    extends Bloc<GenerateReportEvent, GenerateReportState> {
  GenerateReportBloc(
    this._pdfInvoiceService,
    this._notificationManagerService,
  ) : super(GenerateReportInitial.empty()) {
    on<FromMonthInputEvent>(_onFromMonthInputEvent);
    on<ToMonthInputEvent>(_onToMonthInputEvent);
    on<YearInputEvent>(_onYearInputEvent);
    on<GenerateReportButtonPressedEvent>(_onGenerateReportButtonPressedEvent);
  }

  final PdfInvoiceService _pdfInvoiceService;

  final NotificationManagerService _notificationManagerService;

  void _onFromMonthInputEvent(
    FromMonthInputEvent event,
    Emitter<GenerateReportState> emit,
  ) {
    emit(state.copyWith(fromMonth: event.fromMonth));
  }

  void _onToMonthInputEvent(
    ToMonthInputEvent event,
    Emitter<GenerateReportState> emit,
  ) {
    emit(state.copyWith(toMonth: event.toMonth));
  }

  void _onYearInputEvent(
    YearInputEvent event,
    Emitter<GenerateReportState> emit,
  ) {
    emit(state.copyWith(year: event.year));
  }

  Future<void> _onGenerateReportButtonPressedEvent(
    GenerateReportButtonPressedEvent event,
    Emitter<GenerateReportState> emit,
  ) async {
    if (state.fromMonth == 0 || state.toMonth == 0 || state.year == 0) {
      await _notificationManagerService.show<void>(
        NotificationType.signUp,
        title: const Text(
          'Something went wrong',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Please fill all the fields',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );

      return;
    }

    try {
      emit(GenerateReportLoading.from(state));
      await _pdfInvoiceService
          .createReport(
            state.fromMonth,
            state.toMonth,
            state.year,
          )
          .then((value) => emit(GenerateReportSuccess.from(state)));
    } on AuthException catch (e) {
      assert(state is GenerateReportLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            NotificationType.signUp,
            title: const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            message: Text(
              e.message,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          )
          .then(
            (value) =>
                emit((state as GenerateReportLoading).toggleBackToInitial()),
          );
    }
  }
}
