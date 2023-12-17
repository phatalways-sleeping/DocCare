// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCCalendar extends StatefulWidget {
  const DCCalendar({super.key});

  @override
  State<DCCalendar> createState() => _DCCalendarState();
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

class _DCCalendarState extends State<DCCalendar> {
  final int daysInMonth = 30;
  final int firstDayOfWeek = 1; // 0 for Sunday, 1 for Monday, etc.
  final dates = buildCalendarData(mapDatesToWeekday(DateTime.now())).entries;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'].map((weekday) {
        return DCCalendarColumn(
          weekday: weekday,
          dates: dates.firstWhere((element) => element.key == weekday).value,
        );
      }).toList(),
    );
  }
}

class DCCalendarColumn extends StatelessWidget {
  const DCCalendarColumn({
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
            child: DCCalendarButton(
              date: date,
              onPressed: (context) {},
              available: date.isAfter(
                    DateTime.now(),
                  ) ||
                  (date.isBefore(DateTime.now()) && date.day.isEven),
            ),
          ),
      ],
    );
  }
}

class DCCalendarButton extends StatelessWidget {
  const DCCalendarButton({
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
      onTap: () => onPressed(context),
      highlightColor: Colors.white,
      splashColor: Colors.white,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: date.isBefore(DateTime.now())
              ? available
                  ? const Color(0xFFFFD8DF).withOpacity(0.4)
                  : null
              : available
                  ? context.colorScheme.secondary
                  : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.day.toString(),
              style: context.textTheme.bodyRegularPoppins.copyWith(
                fontSize: 14,
                color: date.isBefore(DateTime.now())
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
  }
}
