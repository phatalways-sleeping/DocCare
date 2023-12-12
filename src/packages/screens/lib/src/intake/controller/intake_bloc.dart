import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:model_api/src/intake/service/supabase_intake_api_service.dart';
import 'package:models/models.dart';
import 'package:utility/utility.dart';

part 'intake_event.dart';
part 'intake_state.dart';

class IntakeBloc extends Bloc<IntakeEvent, IntakeState> {
  IntakeBloc(
    this.ID,
    this._supabaseIntakeAPIService,
  ) : super(IntakeInitial.empty()) {
    on<IntakeInitialEvent>(_onIntakeInitialEvent);
    on<IntakeTapEvent>(_onIntakeTapEvent);
  }

  final String ID;
  final SupabaseIntakeAPIService _supabaseIntakeAPIService;

  void _onIntakeInitialEvent(
    IntakeInitialEvent event,
    Emitter<IntakeState> emit,
  ) async {
    try {
      emit(IntakeInitial.empty());
    } catch (e) {
      return;
    }
  }

  void _onIntakeTapEvent(
    IntakeTapEvent event,
    Emitter<IntakeState> emit,
  ) async {
    try {
      emit(IntakeInitial.empty());
    } catch (e) {
      return;
    }
  }
}
