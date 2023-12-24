// ignore_for_file: public_member_api_docs, inference_failure_on_function_invocation, implementation_imports
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:utility/utility.dart'
    show NotificationManagerService, NotificationType;

part 'remove_staff_event.dart';
part 'remove_staff_state.dart';

class RemoveStaffBloc extends Bloc<RemoveStaffEvent, RemoveStaffState> {
  RemoveStaffBloc(
    this._navigatorKey,
    this._notificationManagerService,
    // this._supabaseAdminService,
  ) : super(RemoveStaffLoading.empty()) {
    on<EmailInputEvent>(_onEmailInputEvent);
    on<RoleInputEvent>(_onRoleInputEvent);
    on<RemoveStaffButtonPressedEvent>(_onRemoveStaffButtonPressedEvent);
    on<RemoveStaffLoadingEvent>(_onRemoveStaffLoadingEvent);
    on<SelectEmailEvent>(_onSelectEmailEvent);
  }

  final NotificationManagerService _notificationManagerService;

  final GlobalKey<NavigatorState> _navigatorKey;

  // final AdministratorRepositoryService _supabaseAdminService;

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

  Future<void> _onRemoveStaffLoadingEvent(
    RemoveStaffLoadingEvent event,
    Emitter<RemoveStaffState> emit,
  ) async {
    // get all receptionist emails
    final allReceptionistEmail = await SupabaseReceptionistApiService(
      supabase: Supabase.instance.client,
    ).getAllUserEmail();

    // get all doctor emails
    final allDoctorEmail = await SupabaseDoctorApiService(
      supabase: Supabase.instance.client,
    ).getAllUserEmail();

    emit(
      RemoveStaffInitial.from(
        state.copyWith(
            allReceptionistEmail: allReceptionistEmail,
            allDoctorEmail: allDoctorEmail),
      ),
    );
  }

  Future<void> _onSelectEmailEvent(
    SelectEmailEvent event,
    Emitter<RemoveStaffState> emit,
  ) async {
    final selectedEmails = state.selectedEmails;
    if (state.selectedEmails.contains(event.selectedEmails) == false) {
      selectedEmails.add(event.selectedEmails);
    } else {
      selectedEmails.remove(event.selectedEmails);
    }

    emit(state.copyWith(selectedEmails: selectedEmails));
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
    emit(state.copyWith(role: event.role, selectedEmails: []));
  }

  Future<void> _onRemoveStaffButtonPressedEvent(
    RemoveStaffButtonPressedEvent event,
    Emitter<RemoveStaffState> emit,
  ) async {
    emit(RemoveStaffLoading.from(state));

    try {
      if (state.role == 'Receptionist') {
        // for (final entry in state.selectedEmails) {
        //   // await _supabaseAdminService.deleteReceptionist(entry);
        // }
      } else if (state.role == 'Doctor') {
        // for (final entry in state.selectedEmails) {
        //   await _supabaseAdminService.deleteDoctor(entry);
        // }
      }
      emit(RemoveStaffSuccess.from(state));
    } on AuthException catch (e) {
      assert(state is RemoveStaffLoading, 'State is not loading');

      await _notificationManagerService
          .show<void>(
            _navigatorKey.currentContext!,
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

  @override
  void onChange(Change<RemoveStaffState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
