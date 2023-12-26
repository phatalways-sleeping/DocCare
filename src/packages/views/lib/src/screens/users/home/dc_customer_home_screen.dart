// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:views/src/notification/dc_notification_screen.dart';
import 'package:views/src/screens/users/home/controller/home_bloc.dart';
import 'package:views/src/screens/users/home/widgets/medical_stat_display_widget.dart';
import 'package:views/src/screens/users/home/widgets/reminder_widget.dart';

class DCCustomerHomeScreen extends StatefulWidget {
  const DCCustomerHomeScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _DCCustomerHomeScreen();
}

List<Widget> createAppointmentWidgets(Map<String, List<String>> appointments) {
  final now = DateTime.now();
  // Updated the format to match "07:30:00"
  final format = DateFormat('HH:mm:ss');

  return appointments.entries.map((entry) {
    // Parse the appointment time with the new format
    final appointmentTime = format.parse(entry.value[0]);
    final todayAppointmentTime = DateTime(
      now.year,
      now.month,
      now.day,
      appointmentTime.hour,
      appointmentTime.minute,
      appointmentTime.second, // Add seconds to the DateTime construction
    );

    if (todayAppointmentTime.isBefore(now)) {
      return Container(); // Return an empty container for past appointments
    }
    // Calculate the time left
    final timeLeft = todayAppointmentTime.difference(now);
    String formattedTimeLeft;

    // Display the time in hours and minutes, and add seconds if needed
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
          appointmentTime: format.format(
            todayAppointmentTime,
          ), // Format the DateTime object back to string
        ),
        const SizedBox(height: 8),
      ],
    );
  }).toList();
}

class _DCCustomerHomeScreen extends State<DCCustomerHomeScreen> {
  late PageController _pageController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      // context.read<HomeBloc>().add(const DataLoadingEvent());
      setState(() {
        // Update the time every minute
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        context.read<CustomerRepositoryService>(),
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            BlocProvider.of<HomeBloc>(context).add(
              const DataLoadingEvent(),
            );
          }
          return Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: true,
            appBar: state.currentPage == 0
                ? DCCustomerHeaderBar(
                    title: 'Home',
                    haveNotification: true,
                    onLeadingIconPressed: (context) {},
                    onActionsIconPressed: (context) {
                      _pageController.jumpToPage(1);
                      context.read<HomeBloc>().add(const PageChangedEvent(1));
                    },
                  )
                : DCCustomerHeaderBar(
                    title: 'Notification',
                    allowNavigateBack: true,
                    onLeadingIconPressed: (context) {
                      _pageController.jumpToPage(0);
                      context.read<HomeBloc>().add(const PageChangedEvent(0));
                    },
                  ),
            drawer: const DCCustomerDrawer(),
            body: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (state is! HomeLoading)
                  CustomScrollView(
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
                                  style:
                                      context.textTheme.h6BoldPoppins.copyWith(
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
                                  style: context.textTheme.h6RegularPoppins
                                      .copyWith(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now()),
                                  style: context.textTheme.h6RegularPoppins
                                      .copyWith(
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
                                color: context.colorScheme.quartenary
                                    .withOpacity(0.5),
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
                  )
                else
                  Container(),

                // Add the new page here
                const DCNotificationScreen(),
              ],
            ),
            bottomNavigationBar: const DCCustomerNavigationBar(),
          );
        },
      ),
    );
  }
}
