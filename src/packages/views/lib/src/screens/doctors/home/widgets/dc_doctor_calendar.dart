// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/doctors/home/controller/doctor_home_bloc.dart';

class DCDoctorCalendar extends StatefulWidget {
  const DCDoctorCalendar({super.key});

  @override
  State<DCDoctorCalendar> createState() => _DCDoctorCalendarState();
}

String convertWeekdayToString(int weekday) {
  switch (weekday) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    default:
      return 'Sun';
  }
}

Map<String, List<DateTime>> mapDatesToWeekday(DateTime now) {
  final map = <String, List<DateTime>>{};
  // Find dates before now but within the same month
  for (var i = 1; i < now.day; i++) {
    final date = now.subtract(Duration(days: i));
    if (map.containsKey(convertWeekdayToString(date.weekday))) {
      map[convertWeekdayToString(date.weekday)]!.add(date);
    } else {
      map[convertWeekdayToString(date.weekday)] = [date];
    }
  }
  // Find dates after now but within the same month
  for (var i = 0;
      i <= DateTime(now.year, now.month + 1, 0).day - now.day;
      i++) {
    final date = now.add(Duration(days: i));
    if (map.containsKey(convertWeekdayToString(date.weekday))) {
      map[convertWeekdayToString(date.weekday)]!.add(date);
    } else {
      map[convertWeekdayToString(date.weekday)] = [date];
    }
  }
  // Sort the dates
  for (final key in map.keys) {
    map[key]!.sort((a, b) => a.compareTo(b));
  }
  return map;
}

Map<String, List<DateTime>> buildCalendarData(
    Map<String, List<DateTime>> calendar) {
  // Find the start date of the calendar
  final startDate = calendar.values
      .reduce((value, element) =>
          value.first.compareTo(element.first) < 0 ? value : element)
      .first;
  // Find the end date of the calendar
  final endDate = calendar.values
      .reduce((value, element) =>
          value.last.compareTo(element.last) > 0 ? value : element)
      .last;
  // Find the weekday of the start date
  final startWeekday = startDate.weekday;
  // Find the weekday of the end date
  final endWeekday = endDate.weekday;
  // Padding the start of the calendar if the weekday of the start date is not Monday
  if (startWeekday != 1) {
    for (var i = 1; i < startWeekday; i++) {
      final date = startDate.subtract(Duration(days: i));
      calendar[convertWeekdayToString(date.weekday)]!.insert(0, date);
    }
  }
  // Padding the end of the calendar if the weekday of the end date is not Sunday
  if (endWeekday != 7) {
    for (var i = 1; i <= 7 - endWeekday; i++) {
      final date = endDate.add(Duration(days: i));
      calendar[convertWeekdayToString(date.weekday)]!.add(date);
    }
  }
  return calendar;
}

class _DCDoctorCalendarState extends State<DCDoctorCalendar> {
  final int daysInMonth = 30;
  final int firstDayOfWeek = 1; // 0 for Sunday, 1 for Monday, etc.
  final dates = buildCalendarData(mapDatesToWeekday(DateTime.now())).entries;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((weekday) {
        return DCDoctorCalendarColumn(
          weekday: weekday,
          dates: dates.firstWhere((element) => element.key == weekday).value,
        );
      }).toList(),
    );
  }
}

class DCDoctorCalendarColumn extends StatelessWidget {
  const DCDoctorCalendarColumn({
    required this.weekday,
    required this.dates,
    super.key,
  });

  final String weekday;
  final List<DateTime> dates;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weekday.toUpperCase().substring(0, 1),
          style: context.textTheme.bodyRegularPoppins.copyWith(
            fontSize: 16,
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        for (final date in dates)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
              builder: (context, state) {
                String convertedDate = date.year.toString() +
                    '-' +
                    date.month.toString() +
                    '-' +
                    date.day.toString();
                return DCDoctorCalendarButton(
                  date: date,
                  onPressed: (context) {
                    context.read<DoctorHomeBloc>().add(
                          DoctorHomeOpenDoctorScheduleViewEvent(date: date),
                        );
                  },
                  available: state.appointmentInDate.containsKey(convertedDate),
                );
              },
            ),
          ),
      ],
    );
  }
}

class DCDoctorCalendarButton extends StatelessWidget {
  const DCDoctorCalendarButton({
    required this.date,
    required this.onPressed,
    required this.available,
    super.key,
  });

  final DateTime date;
  final bool available;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        {
          onPressed(context);
        }
      },
      highlightColor: Colors.white,
      splashColor: Colors.white,
      child:
          Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: date.isBefore(DateTime.now().subtract(Duration(days: 1)))
              ? available
                  ? const Color(0xFFFFD8DF).withOpacity(0.4)
                  : null
              : available
                  ? context.colorScheme.secondary
                  : null,
          border: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day, 0, 0, 0) ==
                  DateTime(date.year, date.month, date.day, 0, 0, 0)
              ? Border.all(
                  color: const Color(0xFF6B4EFF),
                  width: 2,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: context.textTheme.bodyRegularPoppins.copyWith(
                fontSize: 14,
                color: date.isBefore(DateTime.now().subtract(Duration(days: 1)))
                    ? available
                        ? const Color(0xFFFF2D55).withOpacity(0.5)
                        : context.colorScheme.onSurface.withOpacity(0.5)
                    : date.month == DateTime.now().month
                        ? context.colorScheme.onSurface
                        : context.colorScheme.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
    // },
    // ),
  }
}
