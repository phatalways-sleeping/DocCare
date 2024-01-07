// ignore_for_file: public_member_api_docs
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
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                  SizedBox(
                    height: context.height,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hi, ${state.name}!',
                                style: context.textTheme.bodyRegularPoppins
                                    .copyWith(
                                  fontSize: 18,
                                  color: context.colorScheme.tertiary,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                'Today: ',
                                style: context.textTheme.bodyRegularPoppins
                                    .copyWith(
                                  fontSize: 18,
                                  color: context.colorScheme.tertiary,
                                ),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                                style: context.textTheme.bodyRegularPoppins
                                    .copyWith(
                                  fontSize: 18,
                                  color: context.colorScheme.tertiary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          BlocSelector<HomeBloc, HomeState,
                              Map<String, List<String>>>(
                            selector: (state) => state.appointments,
                            builder: (context, state) {
                              final body = createAppointmentWidgets(state);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (body.isNotEmpty)
                                    Text(
                                      'Reminders',
                                      style: context
                                          .textTheme.bodyRegularPoppins
                                          .copyWith(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: context.colorScheme.tertiary,
                                      ),
                                    ),
                                  ...createAppointmentWidgets(state),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 10),
                          if (state.bloodPressure != 'N/A') ...[
                            Text(
                              'Your Medical Statistic',
                              style:
                                  context.textTheme.bodyRegularPoppins.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.tertiary,
                              ),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: context.height * 0.4,
                                maxHeight: context.height * 0.48,
                              ),
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                shrinkWrap: true,
                                // padding: const EdgeInsets.symmetric(
                                //   horizontal: 8,
                                // ),
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
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
                                    color: const Color.fromARGB(
                                      255,
                                      163,
                                      241,
                                      232,
                                    ).withOpacity(0.9),
                                    currentValue: state.bloodSugar,
                                    unit: 'mg/dl',
                                    lastCheckupValue: state.oldBloodSugar,
                                  ),
                                ],
                              ),
                            ),
                          ] else
                            Column(
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      SlideAnimatedBox(
                                        begin: const Offset(0, 0.4),
                                        end: Offset.zero,
                                        child: Text(
                                          'Welcome to DocCare!',
                                          style: context.textTheme.h6BoldPoppins
                                              .copyWith(
                                            fontSize: 30,
                                            color: context.colorScheme.tertiary,
                                          ),
                                        ),
                                      ),
                                      SlideAnimatedBox(
                                        duration: const Duration(
                                          milliseconds: 800,
                                        ),
                                        begin: const Offset(0, 0.1),
                                        end: Offset.zero,
                                        child: Image.asset(
                                          'assets/images/pic_1.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 4),
                          Text(
                            'Appointments',
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // TODO(phucchuhoang): Add calendar widget here
                          const SizedBox(height: 50), // Avoid the bottom bar
                        ],
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink(),

                // Add the new page here
                const DCNotificationScreen(),
              ],
            ),
            bottomNavigationBar:
                _currentPage == 0 ? const DCCustomerNavigationBar() : null,
          );
        },
      ),
    );
  }
}
