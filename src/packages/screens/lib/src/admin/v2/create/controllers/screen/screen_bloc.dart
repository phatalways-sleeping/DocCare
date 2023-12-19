// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'screen_event.dart';
part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(const FirstScreen()) {
    on<NavigateToFirstScreen>((event, emit) {
      emit(const FirstScreen());
    });

    on<NavigateToSecondScreen>((event, emit) {
      emit(const SecondScreen());
    });

    on<NavigateToThirdScreen>((event, emit) {
      emit(const ThirdScreen());
    });
  }
}
