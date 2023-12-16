// ignore_for_file: public_member_api_docs, inference_failure_on_function_invocation
import 'dart:async';

import 'package:administrator/administrator.dart';
import 'package:auth_api/auth_api.dart' show AuthException;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:utility/utility.dart'
    show NotificationManagerService, NotificationType;

part 'remove_staff_event.dart';
part 'remove_staff_state.dart';

class RemoveStaffBloc extends Bloc<RemoveStaffEvent, RemoveStaffState> {
  RemoveStaffBloc(
    this._notificationManagerService,
    this._supabaseAdminService,
  ) : super(RemoveStaffInitial.empty()) {
    on<EmailInputEvent>(_onEmailInputEvent);
    on<RoleInputEvent>(_onRoleInputEvent);
    on<RemoveStaffButtonPressedEvent>(_onRemoveStaffButtonPressedEvent);
  }

  final NotificationManagerService _notificationManagerService;

  final AdminControlStaffApiService _supabaseAdminService;

  BuildContext? _context;

  void setContext(BuildContext context) {
    _context = context;
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<RemoveStaffState> emit,
  ) {
    emit(state.copyWith(email: event.email));
  }

  void _showErrorDialog() {
    if (_context != null) {
      showDialog(
        context: _context!,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter the correct email'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _onRoleInputEvent(
    RoleInputEvent event,
    Emitter<RemoveStaffState> emit,
  ) {
    emit(state.copyWith(role: event.role));
  }

  Future<void> _onRemoveStaffButtonPressedEvent(
    RemoveStaffButtonPressedEvent event,
    Emitter<RemoveStaffState> emit,
  ) async {
    emit(RemoveStaffLoading.from(state));

    try {
      if (state.role == "receptionist") {
        await _supabaseAdminService.deleteReceptionist(state.email);
      } else if (state.role == "doctor") {
        await _supabaseAdminService.deleteDoctor(
          state.email,
        );
      }
      emit(RemoveStaffSuccess.from(state));
    } on AuthException catch (e) {
      assert(state is RemoveStaffLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            NotificationType.adminDeleteStaff,
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
                emit((state as RemoveStaffLoading).toggleBackToInitial()),
          );
    }
  }
}
