// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/admin/v2/create/widgets/config.dart';
import 'package:screens/src/admin/v2/create/widgets/dc_speciality_button.dart';

class DCWorkingShiftWidget extends StatelessWidget {
  const DCWorkingShiftWidget({
    required this.onChangedWeekDay,
    required this.onChangedStartPeriod,
    required this.onChangedEndPeriod,
    super.key,
  });

  final void Function(BuildContext context) onChangedWeekDay;
  final void Function(BuildContext context) onChangedStartPeriod;
  final void Function(BuildContext context) onChangedEndPeriod;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Day of the week',
            style: context.textTheme.bodyRegularPoppins.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.tertiary,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        DCSpecialityButton(
          onPressed: onChangedWeekDay,
          hintText: 'Select week day',
          borderColor: context.colorScheme.secondary,
          future: Future.value(
            dayOfWeek,
          ),
          width: context.width * 0.9,
        ),
        gap,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DCSpecialityButton(
                    onPressed: onChangedStartPeriod,
                    hintText: 'Start period',
                    borderColor: context.colorScheme.secondary,
                    future: Future.value(
                      periodData,
                    ),
                    width: context.width * 0.4,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: context.width * 0.05,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DCSpecialityButton(
                    onPressed: onChangedEndPeriod,
                    hintText: 'End period',
                    borderColor: context.colorScheme.secondary,
                    future: Future.value(
                      periodData,
                    ),
                    width: context.width * 0.4,
                  ),
                ],
              ),
            ),
          ],
        ),
        gap,
        Divider(
          color: context.colorScheme.tertiary,
          thickness: 2,
        ),
      ],
    );
  }
}
