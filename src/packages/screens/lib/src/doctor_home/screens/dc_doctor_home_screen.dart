// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/doctor_home/controller/doctor_home_bloc.dart';
import 'package:screens/src/doctor_home/widgets/dc_doctor_calendar.dart';
import 'package:screens/src/doctor_home/widgets/circle_image_with_text.dart';
import 'package:screens/src/doctor_home/widgets/appointment_detail.dart';

class DCDoctorHomeScreen extends StatefulWidget {
  const DCDoctorHomeScreen({
    super.key,
  });

  @override
  _DCDoctorHomeScreenState createState() => _DCDoctorHomeScreenState();
}
String mapMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'July';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    default:
      return 'Dec';
  }
}

class _DCDoctorHomeScreenState extends State<DCDoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCDoctorHeaderBar(
        title: 'DocCare',
      ),
      drawer: const DCDoctorDrawer(),
      bottomNavigationBar: DCDoctorNavigationBar(
        onItemSelected: (BuildContext context, int index) {},
        selectedIndex: 0,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleImageWithText(
              imagePath: 'https://pics.craiyon.com/2023-07-05/a8e9e1290f08447bb300681ce2b563e9.webp',
              welcomeText: 'Welcome Back,',
              name: 'Doctor Wong',
            ),

            SizedBox(height: 20),

            DefaultTextStyle.merge(
              style: context.textTheme.h2BoldPoppins.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onSecondary,
              ),
              textAlign: TextAlign.left,
              child:  Text(
                'Upcoming Appointment',
              )),
            SizedBox(height: 8),


            BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
              buildWhen: (previous, current) {
                if (current.runtimeType != previous.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return AppointmentDetailsWidget(customerName: 'Quoc Le', day: 'Sep, 10, 2023', time: '10:00 AM');
              },
            ),

            SizedBox(height: 10),

            Row(
              children: [
                SvgPicture.string(
                  DCSVGIcons.bookingCalendar,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${mapMonth(DateTime.now().month)} ${DateTime.now().year}',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),


            BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
              buildWhen: (previous, current) {
                if (current.runtimeType != previous.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return DCDoctorCalendar(
                  
                );
              },
            ),

            //DCDoctorCalendar(),
            SizedBox(height: 40),
            // Your calendar widget goes here
            // You can place your existing calendar widget or integrate it here

            // const SizedBox(
            //   height: 10,
            // ),
            // DefaultTextStyle.merge(
            //   style: context.textTheme.h4BoldPoppins.copyWith(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: context.colorScheme.tertiary,
            //   ),
            //   textAlign: TextAlign.left,
            //   child: const Text('Upcoming Appointment'),
            // ),

            // BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
            //   buildWhen: (previous, current) {
            //     if (current.runtimeType != previous.runtimeType) {
            //       return true;
            //     }
            //     return false;
            //   },
            //   builder: (context, state) {
            //     return DCAsyncItems(
            //       future:
            //           context.read<DoctorHomeBloc>().getLatestPrescription(),
            //       isDone: false,
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
