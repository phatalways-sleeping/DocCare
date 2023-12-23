// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:views/src/screens/users/home/controller/home_bloc.dart';
import 'package:views/src/screens/users/home/widgets/medical_stat_display_widget.dart';
import 'package:views/src/screens/users/home/widgets/reminder_widget.dart';

class DCCustomerHomeScreen extends StatefulWidget {
  const DCCustomerHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DCCustomerHomeScreen();
}

List<Widget> createAppointmentWidgets(Map<String, List<String>> appointments) {
  final now = DateTime.now();
  final format = DateFormat('h:mm a');

  return appointments.entries.map((entry) {
    final appointmentTime = format.parse(entry.value[0]);
    var todayAppointmentTime = DateTime(
      now.year,
      now.month,
      now.day,
      appointmentTime.hour,
      appointmentTime.minute,
    );

    if (todayAppointmentTime.isBefore(now)) {
      todayAppointmentTime = todayAppointmentTime.add(const Duration(days: 1));
    }

    // Calculate the time left
    final timeLeft = todayAppointmentTime.difference(now);
    String formattedTimeLeft;

    // Display the time in hours if more than 1 hour, otherwise in minutes
    if (timeLeft.inHours >= 1) {
      formattedTimeLeft = '${timeLeft.inHours} hour(s) left';
    } else if (timeLeft.inMinutes > 0) {
      formattedTimeLeft = '${timeLeft.inMinutes} minute(s) left';
    } else {
      formattedTimeLeft = "Time's up";
    }

    return Column(
      children: [
        ReminderCard(
          content: entry.key,
          timeLeft: formattedTimeLeft,
          appointmentTime: entry.value[0],
        ),
        const SizedBox(height: 8),
      ],
    );
  }).toList();
}

class _DCCustomerHomeScreen extends State<DCCustomerHomeScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Set up the timer
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      setState(() {
        // This empty setState will trigger a rebuild every minute
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            BlocProvider.of<HomeBloc>(context).add(
              const DataLoadingEvent(),
            );
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: true,
            appBar: DCCustomerHeaderBar(
              title: 'Home',
              haveNotification: true,
              onLeadingIconPressed: (context) {},
              onActionsIconPressed: (context) {},
            ),
            drawer: const DCCustomerDrawer(),
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      createAppointmentWidgets(state.appointments),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Hi, ${state.name}!',
                            style: context.textTheme.h6BoldPoppins.copyWith(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Today: ',
                            style: context.textTheme.h6RegularPoppins.copyWith(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy').format(DateTime.now()),
                            style: context.textTheme.h6RegularPoppins.copyWith(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    delegate: SliverChildListDelegate(
                      [
                        CustomHealthCard(
                          title: 'Blood Pressure',
                          icon: DCSVGIcons.bloodDrop,
                          color: context.colorScheme.surface,
                          currentValue: state.bloodPressure,
                          unit: 'mmHg',
                          lastCheckupValue: state.oldBloodPressure,
                        ),
                        CustomHealthCard(
                          title: 'Heart Rate',
                          icon: DCSVGIcons.heart,
                          color:
                              context.colorScheme.quartenary.withOpacity(0.5),
                          currentValue: state.heartRate,
                          unit: 'beats/minute',
                          lastCheckupValue: state.oldHeartRate,
                        ),
                        CustomHealthCard(
                          title: 'Cholesterol',
                          icon: DCSVGIcons.cholesterol,
                          color: context.colorScheme.error,
                          currentValue: state.cholesterol,
                          unit: 'mg/dl',
                          lastCheckupValue: state.oldCholesterol,
                        ),
                        CustomHealthCard(
                          title: 'Glucose',
                          icon: DCSVGIcons.glucometer,
                          color: const Color.fromARGB(255, 163, 241, 232)
                              .withOpacity(0.9),
                          currentValue: state.bloodSugar,
                          unit: 'mg/dl',
                          lastCheckupValue: state.oldBloodSugar,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: const DCCustomerNavigationBar(),
          );
        },
      ),
    );
  }
}
