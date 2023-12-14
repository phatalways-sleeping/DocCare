import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'medicines_event.dart';
part 'medicines_state.dart';

class MedicinesBloc extends Bloc<MedicinesEvent, MedicinesState> {
  MedicinesBloc() : super(MedicinesInitial()) {
    on<MedicinesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
