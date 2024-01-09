// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'receptionist_absent_event.dart';
part 'receptionist_absent_state.dart';

class ReceptionistAbsentBloc
    extends Bloc<ReceptionistAbsentEvent, ReceptionistAbsentState> {
  ReceptionistAbsentBloc(
    this._receptionistRepositoryService,
  ) : super(const ReceptionistAbsentInitial()) {
    on<ReceptionistAbsentResetEvent>((event, emit) {
      emit(const ReceptionistAbsentInitial());
    });
    on<ReceptionistAbsentViewEvent>((event, emit) {
      emit(
        ReceptionistAbsentViewState(
          data: event.data,
        ),
      );
    });
    on<ReceptionistAbsentResponseEvent>((event, emit) async {
      try {
        if (state is! ReceptionistAbsentViewState) {
          throw Exception('Invalid state');
        }
        emit(
          ReceptionistAbsentLoadingState.fromState(
            state: state as ReceptionistAbsentViewState,
          ),
        );
        final castedState = state as ReceptionistAbsentLoadingState;
        await _receptionistRepositoryService.responseAbsentRequest(
          castedState.data['doctorId'] as String,
          date: castedState.data['dateAbsent'] as DateTime,
          isAccepted: event.approved,
        );
        emit(
          ReceptionistAbsentSuccessState.fromState(
            state: state as ReceptionistAbsentLoadingState,
          ),
        );
      } on TimeoutException catch (error) {
        debugPrint(error.toString());
        if (state is! ReceptionistAbsentLoadingState) {
          return _handleInvalidState(emit);
        }
        emit(
          ReceptionistAbsentErrorState.from(
            errorMessage: 'Request timed out',
          ),
        );
      } catch (error) {
        debugPrint(error.toString());
        if (state is! ReceptionistAbsentLoadingState) {
          return _handleInvalidState(emit);
        }
        emit(
          ReceptionistAbsentErrorState.from(
            errorMessage: 'An error occured while trying to submit the form',
          ),
        );
      }
    });
  }

  final ReceptionistRepositoryService _receptionistRepositoryService;

  void _handleInvalidState(Emitter<ReceptionistAbsentState> emit) {
    emit(
      ReceptionistAbsentErrorState.from(
        errorMessage: 'Invalid state, expected ReceptionistAbsentLoadingState',
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getPendingAbsentRequests() =>
      _receptionistRepositoryService.getAbsentRequests();
}
