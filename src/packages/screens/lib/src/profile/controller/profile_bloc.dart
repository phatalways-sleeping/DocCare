import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;
import 'package:model_api/src/users/service/supabase_doctor_api_service.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this.doctorID,
    this._notificationManagerService,
    this._supabaseDoctorApiService,
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
  }

  final String doctorID;
  final NotificationManagerService _notificationManagerService;
  final SupabaseDoctorApiService _supabaseDoctorApiService;

  void _onInitialEvent(
    InitialEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileInitial.empty());
      await _supabaseDoctorApiService.getUser(doctorID).then(
            (value) => emit(
              ProfileInitial.input(
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
    } catch (e) {
      emit(ProfileInitial.empty());
      return;
    }
    emit(state.copyWith());
  }

  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      ProfileOnChange(
          fullName: event.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
          specializationId: state.specializationId,
          startWorkingFrom: state.startWorkingFrom),
    );
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      ProfileOnChange(
          fullName: state.fullName,
          email: event.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
          specializationId: state.specializationId,
          startWorkingFrom: state.startWorkingFrom),
    );
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      ProfileOnChange(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: event.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
          specializationId: state.specializationId,
          startWorkingFrom: state.startWorkingFrom),
    );
  }

  void _onPhoneNumberInputEvent(
    PhoneNumberInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      ProfileOnChange(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: event.phone,
          specializationId: state.specializationId,
          startWorkingFrom: state.startWorkingFrom),
    );
  }

  void _onSpecializationInputEvent(
    SpecializationInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      ProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
        specializationId: event.specializationId,
        startWorkingFrom: state.startWorkingFrom,
      ),
    );
  }

  void _onStartWorkingFromInputEvent(
    StartingYearInputEvent event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      ProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
        specializationId: state.specializationId,
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
            (value) => emit((state as ProfileOnChange).toggleBackToInitial()),
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
