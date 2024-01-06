import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/doctors/home/controller/doctor_home_bloc.dart';
import 'package:views/src/screens/doctors/home/widgets/dc_doctor_async_item.dart';
import 'package:intl/intl.dart';

class DCDoctorScheduleScreen extends StatefulWidget {
  const DCDoctorScheduleScreen({
    super.key,
  });
  @override
  State<DCDoctorScheduleScreen> createState() => _DCDoctorScheduleScreenState();
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

class _DCDoctorScheduleScreenState extends State<DCDoctorScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCDoctorHeaderBar(
        title: 'DocCare',
        allowNavigateBack: true,
        onLeadingIconPressed: (context) => context.read<DoctorHomeBloc>().add(
              const DoctorHomeResetEvent(),
            ),
      ),
      drawer: const DCDoctorDrawer(),
      // bottomNavigationBar: DCCustomerNavigationBar(
      //   onItemSelected: (BuildContext context, int index) {},
      //   selectedIndex: 1,
      // ),
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTextStyle.merge(
              style: context.textTheme.h2BoldPoppins.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.left,
              child: const Text('Your Schedule'),
            ),
            const SizedBox(
              height: 10,
            ),
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
                BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
                  builder: (context, state) {
                    return Text(
                      DateFormat('MMM, dd, yyyy').format(state.selectedDate),
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.left,
              child: const Text('Next Customer'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
              buildWhen: (previous, current) {
                if (previous.runtimeType != current.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                final convertedDate =
                    '${state.selectedDate.year}-${state.selectedDate.month}-${state.selectedDate.day}';
                final appointmentsForDate =
                    state.appointmentInDate[convertedDate];
                final appointmentsNotDone = appointmentsForDate
                    ?.where(
                      (appointment) =>
                          appointment['done'] == false ||
                          appointment['done'] == null,
                    )
                    .toList();

                // Sort appointments by 'period'
                appointmentsNotDone?.sort(
                  (a, b) => int.parse(a['period'].toString())
                      .compareTo(int.parse(b['period'].toString())),
                );

                // Convert the list of appointments to a future
                final futureAppointments =
                    Future.value(appointmentsNotDone ?? []);
                return state.appointmentInDate.containsKey(convertedDate)
                    ? appointmentsNotDone!.isNotEmpty
                        ? DCDoctorAsyncItem(
                            future: futureAppointments,
                            isDone: false,
                            isPast: false,
                            //medicine: true,
                          )
                        : Container()
                    : Container();
              },
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.left,
              child: const Text('Past Appointment'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
              buildWhen: (previous, current) {
                if (previous.runtimeType != current.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                String convertedDate =
                    '${state.selectedDate.year}-${state.selectedDate.month}-${state.selectedDate.day}';
                final appointmentsForDate =
                    state.appointmentInDate[convertedDate];
                // initial the appointmentsDone
                final appointmentsDone = appointmentsForDate
                    ?.where((appointment) => appointment['done'] == true)
                    .toList();

                appointmentsDone?.sort(
                  (a, b) => int.parse(a['period'].toString())
                      .compareTo(int.parse(b['period'].toString())),
                );
                // Convert the list of appointments to a future
                final futureAppointments = Future.value(appointmentsDone ?? []);
                return state.appointmentInDate.containsKey(convertedDate)
                    ? appointmentsDone!.isNotEmpty
                        ? DCDoctorAsyncItem(
                            future: futureAppointments,
                            isDone: true,
                            isPast: true,

                            //medicine: true,
                          )
                        : Container()
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
