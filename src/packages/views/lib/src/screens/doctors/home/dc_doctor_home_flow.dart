import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:controllers/controllers.dart';
import 'package:views/src/screens/doctors/home/controller/doctor_home_bloc.dart';
import 'package:views/src/screens/doctors/home/screens/dc_doctor_schedule_screen.dart';
import 'package:views/src/screens/doctors/home/screens/dc_doctor_home_screen.dart';
import 'package:views/src/screens/doctors/home/screens/dc_doctor_home_waiting.dart';
import 'package:utility/utility.dart';

class DCDoctorHomeFlow extends StatefulWidget {
  const DCDoctorHomeFlow({
    required this.navigatorKey,
    super.key,
  });

  final GlobalKey<NavigatorState> navigatorKey;
//navigatorKey: GlobalKey<NavigatorState>(),
//import 'package:views/src/screens/doctors/home/dc_doctor_home_flow.dart';


  @override
  State<DCDoctorHomeFlow> createState() => _DCDoctorHomeFlowState();
}

class _DCDoctorHomeFlowState extends State<DCDoctorHomeFlow> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorHomeBloc(
        GlobalKey<NavigatorState>(),
        NotificationManager.instance,
        context.read<DoctorRepositoryService>(),
      ),
      child: BlocConsumer<DoctorHomeBloc, DoctorHomeState>(
        listener: (context, state) {
          if (state is DoctorHomeInitial) {
            BlocProvider.of<DoctorHomeBloc>(context).add(
              const DoctorHomeLoadEvent(),
            );
          }
        },
        builder: (context, state) {
          if (state is DoctorHomeInitial) {
            BlocProvider.of<DoctorHomeBloc>(context).add(
              const DoctorHomeLoadEvent(),
            );
          }
          if (state is DoctorHomeLoadedSuccess ||
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
              child: DCDoctorHomeWaitingScreen(),
            );
          }
        },
      ),
    );
  }
}
