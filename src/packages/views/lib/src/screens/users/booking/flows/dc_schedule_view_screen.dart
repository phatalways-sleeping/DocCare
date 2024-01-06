// ignore_for_file: public_member_api_docs

import 'package:controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_booking_with_doctor_screen.dart';
import 'package:views/src/screens/users/booking/doctor_view/controller/doctor_view_bloc.dart';

class DCScheduleViewScreen extends StatelessWidget {
  const DCScheduleViewScreen({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorViewBloc>(
          create: (context) =>
              DoctorViewBloc(context.read<CustomerRepositoryService>()),
        ),
        BlocProvider<BookingBloc>(
          create: (context) =>
              BookingBloc(context.read<CustomerRepositoryService>()),
        )
      ],
      key: navigatorKey,
      child: const DCBookingWithDoctorScreen(),
    );
  }
}
