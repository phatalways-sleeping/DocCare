import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:utility/utility.dart'
    show FormValidator, NotificationManagerService, NotificationType;
import 'package:model_api/src/users/service/supabase_receptionist_api_service.dart';
part 'receptionist_profile_event.dart';
part 'receptionist_profile_state.dart';

class ReceptionistProfileBloc
    extends Bloc<ReceptionistProfileEvent, ReceptionistProfileState> {
  ReceptionistProfileBloc(
    this.patientID,
    this._notificationManagerService,
    this._supabaseReceptionistApiService,
  ) : super(ReceptionistProfileInitial.empty()) {
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
  final SupabaseReceptionistApiService _supabaseReceptionistApiService;

  void _onInitialEvent(
    InitialEvent event,
    Emitter<ReceptionistProfileState> emit,
  ) async {
    try {
      emit(ReceptionistProfileInitial.empty());
      await _supabaseReceptionistApiService.getUser(patientID).then(
            (value) => emit(
              ReceptionistProfileInitial.input(
                fullName: value.fullname,
                email: value.email,
                tempBirthday: value.birthday.toString(),
                birthday: value.birthday ?? DateTime.now(),
                phone: value.phone,
              ),
            ),
          );
    } catch (e) {
      emit(ReceptionistProfileInitial.empty());
      return;
    }
    emit(state.copyWith());
  }

  //TODO (Vinh): Loading state animation. Might separate to another state
  void _onFullNameInputEvent(
    FullNameInputEvent event,
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(
      ReceptionistProfileOnChange(
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
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(
      ReceptionistProfileOnChange(
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
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit((state as ReceptionistProfileOnChange).toggleBackToInitial());
  }

  Future<void> _onConfirmButtonPressedEvent(
    ConfirmButtonPressedEvent event,
    Emitter<ReceptionistProfileState> emit,
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
        ReceptionistProfileLoading(
          fullName: state.fullName,
          email: state.email,
          tempBirthday: state.tempBirthday,
          birthday: state.birthday,
          phone: state.phone,
        ),
      );
      //print('Update in process');
      await Future.wait([
        _supabaseReceptionistApiService.updateFullName(
          patientID,
          state.fullName,
        ),
        _supabaseReceptionistApiService.updateEmail(
          patientID,
          state.email,
        ),
        _supabaseReceptionistApiService.updateBirthday(
          patientID,
          state.birthday,
        ),
        _supabaseReceptionistApiService.updatePhone(
          patientID,
          state.phone,
        ),
      ]);
    } catch (e) {
      assert(state is ReceptionistProfileLoading, 'Loading failed');
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
              emit((state as ReceptionistProfileLoading).toggleBackToInitial()),
        );
  }

  void _onBirthdayInputEvent(
    BirthdayInputEvent event,
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(
      ReceptionistProfileOnChange(
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
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(
      ReceptionistProfileOnChange(
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
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(
      ReceptionistProfileOnChange(
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
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(
      ReceptionistProfileOnChange(
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
    Emitter<ReceptionistProfileState> emit,
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
            (value) => emit(
                (state as ReceptionistProfileOnChange).toggleBackToInitial()),
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
    Emitter<ReceptionistProfileState> emit,
  ) {
    emit(state.copyWith());
  }
}
