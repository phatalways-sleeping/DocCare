// ignore_for_file: public_member_api_docs

import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_booking_with_doctor_screen.dart';

class DCScheduleViewScreen extends StatelessWidget {
  const DCScheduleViewScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      key: navigatorKey,
      create: (context) =>
          BookingBloc(context.read<CustomerRepositoryService>()),
      child: const DCBookingWithDoctorScreen(),
    );
  }
}
