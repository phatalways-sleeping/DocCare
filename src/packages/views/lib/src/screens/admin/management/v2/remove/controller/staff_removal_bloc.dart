// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'staff_removal_event.dart';
part 'staff_removal_state.dart';

class StaffRemovalBloc extends Bloc<StaffRemovalEvent, StaffRemovalState> {
  StaffRemovalBloc() : super(StaffRemovalInitial.initial()) {
    on<StaffRemovalResetEvent>(_onStaffRemovalResetEvent);
    on<StaffRemovalRoleChangedEvent>(_onStaffRemovalRoleChangedEvent);
    on<StaffRemovalEmailChangedEvent>(_onStaffRemovalEmailChangedEvent);
    on<StaffRemovalSubmitEvent>(_onStaffRemovalSubmitEvent);
  }

  @override
  void onTransition(Transition<StaffRemovalEvent, StaffRemovalState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  void _onStaffRemovalResetEvent(
    StaffRemovalResetEvent event,
    Emitter<StaffRemovalState> emit,
  ) {
    emit(
      StaffRemovalInitial.fromState(state),
    );
  }

  void _onStaffRemovalRoleChangedEvent(
    StaffRemovalRoleChangedEvent event,
    Emitter<StaffRemovalState> emit,
  ) {
    emit(state.copyWith(role: event.role));
  }

  void _onStaffRemovalEmailChangedEvent(
    StaffRemovalEmailChangedEvent event,
    Emitter<StaffRemovalState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _onStaffRemovalSubmitEvent(
    StaffRemovalSubmitEvent event,
    Emitter<StaffRemovalState> emit,
  ) async {
    try {
      emit(StaffRemovalLoading.fromState(state));
      await Future.delayed(const Duration(seconds: 2), () {});
      // throw Exception();

      emit(StaffRemovalSuccess.fromState(state));
    } catch (error) {
      emit(
        StaffRemovalFailure.fromState(
          state: state,
          errorMessage: 'Failed to remove staff.\nPlease try again.',
        ),
      );
    }
  }
}
