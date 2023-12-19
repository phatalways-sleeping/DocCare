import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'receptionist_absent_event.dart';
part 'receptionist_absent_state.dart';

class ReceptionistAbsentBloc extends Bloc<ReceptionistAbsentEvent, ReceptionistAbsentState> {
  ReceptionistAbsentBloc() : super(ReceptionistAbsentInitial()) {
    on<ReceptionistAbsentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
