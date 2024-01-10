// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'staff_removal_event.dart';
part 'staff_removal_state.dart';

class StaffRemovalBloc extends Bloc<StaffRemovalEvent, StaffRemovalState> {
  StaffRemovalBloc(
    this._authenticationRepositoryService,
    this._administratorRepositoryService,
  ) : super(StaffRemovalInitial.initial()) {
    on<StaffRemovalResetEvent>(_onStaffRemovalResetEvent);
    on<StaffRemovalRoleChangedEvent>(_onStaffRemovalRoleChangedEvent);
    on<StaffRemovalEmailChangedEvent>(_onStaffRemovalEmailChangedEvent);
    on<StaffRemovalSubmitEvent>(_onStaffRemovalSubmitEvent);
  }

  final AuthenticationRepositoryService _authenticationRepositoryService;
  final AdministratorRepositoryService _administratorRepositoryService;

  @override
  void onTransition(
      Transition<StaffRemovalEvent, StaffRemovalState> transition) {
    debugPrint(transition.toString());
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
      final user = await _authenticationRepositoryService
          .fetchUserByEmail(
            state.email,
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          );

      if (user == null) {
        throw Exception('User not found');
      }

      debugPrint('User found: ${user.id}');

      await _authenticationRepositoryService
          .disableAccount(
            user.id,
          )
          .timeout(
            const Duration(
              seconds: 30,
            ),
          ).then((value) {
            debugPrint('Account disabled');
          });



      await _administratorRepositoryService.disableDoctor(
        user.email!,
      ).then((value) {
        debugPrint('Doctor disabled');
      });

      emit(StaffRemovalSuccess.fromState(state));
    } on TimeoutException catch (_) {
      emit(
        StaffRemovalFailure.fromState(
          state: state,
          errorMessage: 'Failed to remove staff.\nOperation timed out.',
        ),
      );
    } catch (error) {
      emit(
        StaffRemovalFailure.fromState(
          state: state,
          errorMessage: 'Failed to remove staff.\nPlease try again.',
        ),
      );
    }
  }

  Future<List<String>> getEmails(String role) async =>
      _authenticationRepositoryService.getEmails(role);
}
