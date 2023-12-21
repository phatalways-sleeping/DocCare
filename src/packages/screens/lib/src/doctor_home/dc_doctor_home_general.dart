// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model_api/model_api.dart';
import 'package:screens/src/doctor_home/controller/doctor_home_bloc.dart';
import 'package:screens/src/doctor_home/dc_doctor_schedule_screen.dart';
import 'package:screens/src/doctor_home/dc_doctor_home_screen.dart';

// ignore: depend_on_referenced_packages
import 'package:supabase_flutter/supabase_flutter.dart';

class DCDoctorHomeGeneral extends StatefulWidget {
  const DCDoctorHomeGeneral({
    required this.doctorID,
    super.key,
  });

  final String doctorID;

  @override
  State<DCDoctorHomeGeneral> createState() => _DCDoctorHomeGeneralState();
}

class _DCDoctorHomeGeneralState extends State<DCDoctorHomeGeneral> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorHomeBloc(
        widget.doctorID,
        //SupabasePrescriptionApiService(supabase: Supabase.instance.client),
        SupabaseDoctorApiService(supabase: Supabase.instance.client),
        //SupabaseIntakeAPIService(supabase: Supabase.instance.client),
      )..add(
          const DoctorHomeInitialEvent(),
        ),
      child: BlocConsumer<DoctorHomeBloc, DoctorHomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is DoctorHomeInitial) {
            return DCDoctorHomeScreen(
              doctorID: widget.doctorID,
            );
          } else if (state is DoctorScheduleInitial) {
            return DCDoctorScheduleScreen(
              day: state.currentDay,
              month: state.currentMonth,
              year: state.currentYear,
              doctorID: widget.doctorID,
            );
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