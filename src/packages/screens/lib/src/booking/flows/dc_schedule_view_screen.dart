// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/booking/booking_view/controller/booking_bloc.dart';
import 'package:screens/src/booking/booking_view/dc_booking_with_doctor_screen.dart';

class DCScheduleViewScreen extends StatelessWidget {
  const DCScheduleViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc(),
      child: const DCBookingWithDoctorScreen(),
    );
  }
}
