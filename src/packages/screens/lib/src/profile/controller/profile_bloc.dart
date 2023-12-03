import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;
import 'package:model_api/src/users/service/supabase_doctor_api_service.dart';
import 'package:model_api/src/users/service/supabase_patient_api_service.dart';
import 'package:model_api/src/users/service/supabase_receptionist_api_service.dart';
part 'profile_event.dart';
part 'profile_state.dart';

String getIDType(String ID) {
  if (ID[0] == 'D')
    return 'DOCTOR';
  else if (ID[0] == 'C')
    return 'CUSTOMER';
  else
    return 'RECEPTIONIST';
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileInitial> {
  ProfileBloc(
    this.ID,
    this._notificationManagerService,
    this._supabaseDoctorApiService,
    this._supabasePatientApiService,
    this._supabaseReceptionistApiService,
  ) : super(ProfileInitial.empty()) {
    on<InitialEvent>(_onInitialEvent);
    on<FullNameInputEvent>(_onFullNameInputEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<BirthdayInputEvent>(_onBirthdayInputEvent);
    on<PhoneNumberInputEvent>(_onPhoneNumberInputEvent);
    on<SpecializationInputEvent>(_onSpecializationInputEvent);
    on<StartingYearInputEvent>(_onStartWorkingFromInputEvent);
    on<ValidateBirthdayInputEvent>(_onValidateBirthdayInputEvent);
    on<ChangePasswordButtonPressedEvent>(_onChangePasswordButtonPressedEvent);
    on<ConfirmButtonPressedEvent>(_onConfirmButtonPressedEvent);
    on<CancelButtonPressedEvent>(_onCancelButtonPressedEvent);
  }

  final String ID;
  final NotificationManagerService _notificationManagerService;
  final SupabaseDoctorApiService _supabaseDoctorApiService;
  final SupabaseCustomerApiService _supabasePatientApiService;
  final SupabaseReceptionistApiService _supabaseReceptionistApiService;

  void _onInitialEvent(
    InitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      if (getIDType(ID) == 'DOCTOR') {
        emit(DoctorProfileInitial.empty());
        await _supabaseDoctorApiService?.getUser(ID).then(
              (value) => emit(
                DoctorProfileInitial.input(
                  fullName: value.fullname,
                  email: value.email,
                  tempBirthday: value.birthday.toString(),
                  birthday: value.birthday ?? DateTime.now(),
                  phone: value.phone,
                  specializationId: value.specializationId,
                  startWorkingFrom: value.startWorkingFrom,
                ),
              ),
            );
      } else if (getIDType(ID) == 'CUSTOMER') {
        emit(ProfileInitial.empty());
        await _supabasePatientApiService?.getUser(ID).then(
              (value) => emit(
                ProfileInitial.input(
                  fullName: value.fullname,
                  email: value.email,
                  tempBirthday: value.birthday.toString(),
                  birthday: value.birthday ?? DateTime.now(),
                  phone: value.phone,
                ),
              ),
            );
      } else if (getIDType(ID) == 'RECEPTIONIST') {
        emit(ProfileInitial.empty());
        await _supabaseReceptionistApiService?.getUser(ID).then(
              (value) => emit(
                ProfileInitial.input(
                  fullName: value.fullname,
                  email: value.email,
                  tempBirthday: value.birthday.toString(),
                  birthday: value.birthday ?? DateTime.now(),
                  phone: value.phone,
                ),
              ),
            );
      }
    } catch (e) {
      if (getIDType(ID) == 'DOCTOR') {
        emit(DoctorProfileInitial.empty());
      } else {
        emit(ProfileInitial.empty());
      }
      return;
    }
    emit(state.copyWith());
  }

  //TODO (Vinh): Loading state animation. Might separate to another state
  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (getIDType(ID) == 'DOCTOR') {
      emit(
        DoctorProfileOnChange(
          fullName: event.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
          specializationId: (state as DoctorProfileInitial).specializationId,
          startWorkingFrom: (state as DoctorProfileOnChange).startWorkingFrom,
        ),
      );
    } else {
      emit(
        ProfileOnChange(
          fullName: event.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
        ),
      );
    }
  }

  void _onPhoneNumberInputEvent(
    PhoneNumberInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (getIDType(ID) == 'DOCTOR') {
      emit(
        DoctorProfileOnChange(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: event.phone,
          specializationId: (state as DoctorProfileInitial).specializationId,
          startWorkingFrom: (state as DoctorProfileOnChange).startWorkingFrom,
        ),
      );
    } else {
      emit(
        ProfileOnChange(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: event.phone,
        ),
      );
    }
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (getIDType(ID) == 'DOCTOR') {
      emit(
        DoctorProfileOnChange(
          fullName: state.fullName,
          email: event.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
          specializationId: (state as DoctorProfileInitial).specializationId,
          startWorkingFrom: (state as DoctorProfileOnChange).startWorkingFrom,
        ),
      );
    } else {
      emit(
        ProfileOnChange(
          fullName: state.fullName,
          email: event.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
        ),
      );
    }
  }

  void _onCancelButtonPressedEvent(
    CancelButtonPressedEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (getIDType(ID) == 'DOCTOR') {
      emit((state as DoctorProfileOnChange).toggleBackToInitial());
    } else {
      emit((state as ProfileOnChange).toggleBackToInitial());
    }
  }

  Future<void> _onConfirmButtonPressedEvent(
    ConfirmButtonPressedEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.fullName.isEmpty ||
        state.email.isEmpty ||
        state.email.isEmpty ||
        state.phone.isEmpty ||
        (getIDType(ID) == 'DOCTOR' &&
            (state as DoctorProfileOnChange).specializationId.isEmpty) ||
        (getIDType(ID) == 'DOCTOR' &&
            (state as DoctorProfileOnChange).startWorkingFrom == 0)) {
      await _notificationManagerService.show<void>(
        NotificationType.signUp,
        title: const Text(
          'There is an empty field in your profile',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        message: const Text(
          'Please fill in all the fields',
          style: TextStyle(fontSize: 13),
        ),
      );

      return;
    }
    try {
      if (getIDType(ID) == 'DOCTOR') {
        emit(
          DoctorProfileLoading(
            fullName: state.fullName,
            email: state.email,
            tempBirthday: state.tempBirthday,
            birthday: state.birthday,
            phone: state.phone,
            specializationId: (state as DoctorProfileOnChange).specializationId,
            startWorkingFrom: (state as DoctorProfileOnChange).startWorkingFrom,
          ),
        );
      } else {
        emit(
          ProfileLoading(
            fullName: state.fullName,
            email: state.email,
            tempBirthday: state.tempBirthday,
            birthday: state.birthday,
            phone: state.phone,
          ),
        );
      }
      //print('Update in process');
      if (getIDType(ID) == 'DOCTOR') {
        await Future.wait([
          _supabaseDoctorApiService?.updateFullName(
            ID,
            state.fullName,
          ),
          _supabaseDoctorApiService?.updateEmail(
            ID,
            state.email,
          ),
          _supabaseDoctorApiService?.updateBirthday(
            ID,
            state.birthday,
          ),
          _supabaseDoctorApiService?.updatePhone(
            ID,
            state.phone,
          ),
          _supabaseDoctorApiService?.updateSpecialty(
            ID,
            (state as DoctorProfileOnChange).specializationId,
          ),
          _supabaseDoctorApiService?.updateStartWorkingFrom(
            ID,
            (state as DoctorProfileOnChange).startWorkingFrom,
          ),
        ] as Iterable<Future>);
      } else if (getIDType(ID) == 'CUSTOMER') {
        await Future.wait(
          [
            _supabasePatientApiService?.updateFullName(
              ID,
              state.fullName,
            ),
            _supabasePatientApiService?.updateEmail(
              ID,
              state.email,
            ),
            _supabasePatientApiService?.updateBirthday(
              ID,
              state.birthday,
            ),
            _supabasePatientApiService?.updatePhone(
              ID,
              state.phone,
            ),
          ] as Iterable<Future>,
        );
      } else if (getIDType(ID) == 'RECEPTIONIST') {
        await Future.wait([
          _supabaseReceptionistApiService?.updateFullName(
            ID,
            state.fullName,
          ),
          _supabaseReceptionistApiService?.updateEmail(
            ID,
            state.email,
          ),
          _supabaseReceptionistApiService?.updateBirthday(
            ID,
            state.birthday,
          ),
          _supabaseReceptionistApiService?.updatePhone(
            ID,
            state.phone,
          ),
        ] as Iterable<Future>);
      }
    } catch (e) {
      assert(state is ProfileLoading, 'Loading failed');
    }

    await _notificationManagerService
        .show<void>(
          NotificationType.signUp,
          title: const Text(
            'Your profile has been updated',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          message: const Text(
            'Your profile has been updated successfully',
            style: TextStyle(fontSize: 13),
          ),
        )
        .then(
          (value) =>
              emit((state as DoctorProfileLoading).toggleBackToInitial()),
        );
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    if (getIDType(ID) == 'DOCTOR') {
      emit(
        DoctorProfileOnChange(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: event.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
          specializationId: (state as DoctorProfileInitial).specializationId,
          startWorkingFrom: (state as DoctorProfileOnChange).startWorkingFrom,
        ),
      );
    } else {
      emit(
        ProfileOnChange(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: event.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
        ),
      );
    }
  }

  void _onSpecializationInputEvent(
    SpecializationInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      DoctorProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
        specializationId: event.specializationId,
        startWorkingFrom: (state as DoctorProfileInitial).startWorkingFrom,
      ),
    );
  }

  void _onStartWorkingFromInputEvent(
    StartingYearInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      DoctorProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
        specializationId: (state as DoctorProfileInitial).specializationId,
        startWorkingFrom: event.startWorkingFrom,
      ),
    );
  }

  void _onValidateBirthdayInputEvent(
    ValidateBirthdayInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    final check = FormValidator.validateDate(event.tempBirthday).isValid;
    if (!check) {
      _notificationManagerService
          .show<void>(
            NotificationType.signUp,
            title: const Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            message: const Text(
              'Please enter a valid date with valid format (dd/mm/yyyy)',
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          )
          .then(
            (value) =>
                emit((state as DoctorProfileOnChange).toggleBackToInitial()),
          );
      return;
    }
    final formatter = DateFormat('dd/MM/yyyy');
    final birthday = formatter.parseStrict(
      event.tempBirthday,
    );
    emit(state.copyWith(birthday: birthday));
  }

  void _onChangePasswordButtonPressedEvent(
    ChangePasswordButtonPressedEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(state.copyWith());
  }
}
