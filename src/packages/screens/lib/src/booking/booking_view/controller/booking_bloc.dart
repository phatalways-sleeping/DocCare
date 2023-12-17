// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    Map<String, dynamic> doctorData = const {},
  }) : super(BookingInitial(
          doctorData: doctorData,
        )) {
    on<BookingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
