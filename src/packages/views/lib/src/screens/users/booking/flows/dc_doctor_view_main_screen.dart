// ignore_for_file: public_member_api_docs

import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_booking_with_doctor_screen.dart';
import 'package:views/src/screens/users/booking/doctor_view/controller/doctor_view_bloc.dart';

import 'package:views/src/screens/users/booking/doctor_view/filter/dc_doctor_filter.dart';
import 'package:views/src/screens/users/booking/doctor_view/view/dc_doctor_view.dart';

class DCDoctorViewMainScreen extends StatefulWidget {
  const DCDoctorViewMainScreen({
    required this.navigatorKey,
    super.key,
    this.inCustomerView = true,
  });

  final bool inCustomerView;

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<DCDoctorViewMainScreen> createState() => _DCDoctorViewMainScreenState();
}

class _DCDoctorViewMainScreenState extends State<DCDoctorViewMainScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorViewBloc(),
      child: BlocBuilder<DoctorViewBloc, DoctorViewState>(
        builder: (context, state) {
          return FlowBuilder<DoctorViewState>(
            key: widget.navigatorKey,
            state: state,
            onGeneratePages: (state, pages) {
              return [
                if (state is DoctorViewInitial ||
                    state is DoctorViewSearchForName)
                  const MaterialPage(
                    child: DCDoctorViewScreen(),
                  ),
                if (state is DoctorViewFilter)
                  const MaterialPage(
                    child: DCDoctorFilterScreen(),
                  ),
                if (state is DoctorViewChooseDoctor)
                  MaterialPage(
                    child: BlocProvider(
                      create: (context) => BookingBloc(
                        doctorData: state.doctor,
                      ),
                      child: DCBookingWithDoctorScreen(
                        inCustomerView: widget.inCustomerView,
                      ),
                    ),
                  ),
              ];
            },
          );
        },
      ),
    );
  }
}
