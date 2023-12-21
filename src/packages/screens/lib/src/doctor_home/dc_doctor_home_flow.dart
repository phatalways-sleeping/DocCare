
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/doctor_home/controller/doctor_home_bloc.dart';
import 'package:screens/src/doctor_home/screens/dc_doctor_schedule_screen.dart';
import 'package:screens/src/doctor_home/screens/dc_doctor_home_screen.dart';
//import 'package:utility/utility.dart';

class DCDoctorHomeFlow extends StatefulWidget {
  const DCDoctorHomeFlow({
    super.key,
  });

  @override
  State<DCDoctorHomeFlow> createState() =>
      _DCDoctorHomeFlowState();
}

class _DCDoctorHomeFlowState
    extends State<DCDoctorHomeFlow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorHomeBloc(
        //NotificationManager.instance,
      ),
      child: BlocConsumer<DoctorHomeBloc, DoctorHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DoctorHomeViewState ||
              state is DoctorHomeViewLoadingState 
              //||
             // state is IntakeViewState ||
              //state is IntakeViewRatingResultState
              ) {
            return const DCDoctorHomeScreen();
          } else if (state is DoctorScheduleViewState ||
              state is DoctorScheduleViewLoadingState) {
            return const DCDoctorScheduleScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}