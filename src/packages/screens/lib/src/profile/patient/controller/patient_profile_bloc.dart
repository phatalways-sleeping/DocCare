import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;
import 'package:model_api/src/users/service/supabase_patient_api_service.dart';
part 'patient_profile_event.dart';
part 'patient_profile_state.dart';

class PatientProfileBloc
    extends Bloc<PatientProfileEvent, PatientProfileState> {
  PatientProfileBloc(
    this.patientID,
    this._notificationManagerService,
    this._supabaseCustomerApiService,
  ) : super(PatientProfileInitial.empty()) {
    on<InitialEvent>(_onInitialEvent);
    on<FullNameInputEvent>(_onFullNameInputEvent);
    on<EmailInputEvent>(_onEmailInputEvent);
    on<BirthdayInputEvent>(_onBirthdayInputEvent);
    on<PhoneNumberInputEvent>(_onPhoneNumberInputEvent);
    on<ValidateBirthdayInputEvent>(_onValidateBirthdayInputEvent);
    on<ChangePasswordButtonPressedEvent>(_onChangePasswordButtonPressedEvent);
    on<ConfirmButtonPressedEvent>(_onConfirmButtonPressedEvent);
    on<CancelButtonPressedEvent>(_onCancelButtonPressedEvent);
  }

  final String patientID;
  final NotificationManagerService _notificationManagerService;
  final SupabaseCustomerApiService _supabaseCustomerApiService;

  void _onInitialEvent(
    InitialEvent event,
    Emitter<PatientProfileState> emit,
  ) async {
    try {
      emit(PatientProfileInitial.empty());
      await _supabaseCustomerApiService.getUser(patientID).then(
            (value) => emit(
              PatientProfileInitial.input(
                fullName: value.fullname,
                email: value.email,
                tempBirthday: value.birthday.toString(),
                birthday: value.birthday ?? DateTime.now(),
                phone: value.phone,
              ),
            ),
          );
    } catch (e) {
      emit(PatientProfileInitial.empty());
      return;
    }
    emit(state.copyWith());
  }

  //TODO (Vinh): Loading state animation. Might separate to another state
  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit(
      PatientProfileOnChange(
        fullName: event.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
      ),
    );
  }

  void _onEmailInputEvent(
    EmailInputEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit(
      PatientProfileOnChange(
        fullName: state.fullName,
        email: event.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
      ),
    );
  }

  void _onCancelButtonPressedEvent(
    CancelButtonPressedEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit((state as PatientProfileOnChange).toggleBackToInitial());
  }

  Future<void> _onConfirmButtonPressedEvent(
    ConfirmButtonPressedEvent event,
    Emitter<PatientProfileState> emit,
  ) async {
    if (state.fullName.isEmpty ||
        state.email.isEmpty ||
        state.email.isEmpty ||
        state.phone.isEmpty) {
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
      emit(
        PatientProfileLoading(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
        ),
      );
      //print('Update in process');
      await Future.wait([
        _supabaseCustomerApiService.updateFullName(
          patientID,
          state.fullName,
        ),
        _supabaseCustomerApiService.updateEmail(
          patientID,
          state.email,
        ),
        _supabaseCustomerApiService.updateBirthday(
          patientID,
          state.birthday,
        ),
        _supabaseCustomerApiService.updatePhone(
          patientID,
          state.phone,
        ),
      ]);
    } catch (e) {
      assert(state is PatientProfileLoading, 'Loading failed');
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
              emit((state as PatientProfileLoading).toggleBackToInitial()),
        );
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit(
      PatientProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: event.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
      ),
    );
  }

  void _onPhoneNumberInputEvent(
    PhoneNumberInputEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit(
      PatientProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: event.phone,
      ),
    );
  }

  void _onSpecializationInputEvent(
    SpecializationInputEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit(
      PatientProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
      ),
    );
  }

  void _onStartWorkingFromInputEvent(
    StartingYearInputEvent event,
    Emitter<PatientProfileState> emit,
  ) {
    emit(
      PatientProfileOnChange(
        fullName: state.fullName,
        email: state.email,
        tempBirthday: state.tempBirthday,
        birthday: state.birthday,
        phone: state.phone,
      ),
    );
  }

  void _onValidateBirthdayInputEvent(
    ValidateBirthdayInputEvent event,
    Emitter<PatientProfileState> emit,
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
                emit((state as PatientProfileOnChange).toggleBackToInitial()),
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
    Emitter<PatientProfileState> emit,
  ) {
    emit(state.copyWith());
  }
}
