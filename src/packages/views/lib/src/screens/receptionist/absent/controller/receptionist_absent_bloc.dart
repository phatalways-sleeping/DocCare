// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'receptionist_absent_event.dart';
part 'receptionist_absent_state.dart';

class ReceptionistAbsentBloc
    extends Bloc<ReceptionistAbsentEvent, ReceptionistAbsentState> {
  ReceptionistAbsentBloc() : super(const ReceptionistAbsentInitial()) {
    on<ReceptionistAbsentResetEvent>((event, emit) {
      emit(const ReceptionistAbsentInitial());
    });
    on<ReceptionistAbsentViewEvent>((event, emit) {
      emit(
        ReceptionistAbsentViewState(
          doctorId: event.doctorId,
          date: event.date,
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

        await Future.delayed(const Duration(seconds: 4), () {});

        emit(
          ReceptionistAbsentSuccessState.fromState(
            state: state as ReceptionistAbsentLoadingState,
          ),
        );
      } catch (error) {
        if (state is! ReceptionistAbsentLoadingState) {
          return emit(
            ReceptionistAbsentErrorState.from(
              errorMessage:
                  'Invalid state, expected ReceptionistAbsentLoadingState',
            ),
          );
        }
        emit(
          ReceptionistAbsentErrorState.from(
            errorMessage: 'An error occured while trying to submit the form',
          ),
        );
      }
    });
  }
}