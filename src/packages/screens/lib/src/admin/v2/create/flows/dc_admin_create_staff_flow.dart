// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/v2/create/controllers/create_staff/create_staff_bloc.dart';
import 'package:screens/src/admin/v2/create/controllers/screen/screen_bloc.dart';
import 'package:screens/src/admin/v2/create/screens/dc_create_staff_entrance.dart';
import 'package:screens/src/admin/v2/create/screens/dc_create_staff_review.dart';
import 'package:screens/src/admin/v2/create/screens/dc_create_staff_second.dart';

class DCAdminCreateStaffFlow extends StatelessWidget {
  const DCAdminCreateStaffFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScreenBloc>(
          create: (context) => ScreenBloc(),
        ),
        BlocProvider<StaffCreationBloc>(
          create: (context) => StaffCreationBloc(),
        ),
      ],
      child: BlocBuilder<ScreenBloc, ScreenState>(
        builder: (context, state) {
          if (state is FirstScreen) {
            return const DCCreateStaffEntrance();
          }
          if (state is SecondScreen) {
            return const DCCreateStaffSecond();
          }
          if (state is ThirdScreen) {
            return const DCCreateStaffReview();
          }
          return const DCCreateStaffEntrance();
        },
      ),
    );
  }
}
