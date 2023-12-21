// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/prescription_bloc.dart';

class TimeOfDaySelector extends StatefulWidget {
  const TimeOfDaySelector({
    super.key,
  });

  @override
  State<TimeOfDaySelector> createState() => _TimeOfDaySelectorState();
}

class _TimeOfDaySelectorState extends State<TimeOfDaySelector> {
  final List<String> _timesOfDay = ['Morning', 'Afternoon', 'Evening', 'Night'];
  final List<bool> _selectedTimes = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    // Calculate the width and height based on the screen size
    final chipWidth = context.width * 0.43;
    final chipHeight = context.height * 0.05;

    // Create two lists of widgets for each row
    final firstRow = <Widget>[];
    final secondRow = <Widget>[];

    for (var i = 0; i < _timesOfDay.length; i++) {
      final chip = Container(
        width: chipWidth,
        height: chipHeight,
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.error,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Material(
          color: _selectedTimes[i]
              ? context.colorScheme.error
              : context.colorScheme.background,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedTimes[i] = !_selectedTimes[i];
              });
              BlocProvider.of<PrescriptionBloc>(context)
                  .add(MedicineTimeTakenInputEvent(i));
            },
            borderRadius: BorderRadius.circular(30),
            child: Center(
              child: Text(
                _timesOfDay[i],
                style: context.textTheme.h6BoldPoppins.copyWith(
                  fontSize: 16,
                  color: context.colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ),
      );

      // Assign the chip to the appropriate row
      if (i < 2) {
        firstRow.add(chip);
      } else {
        secondRow.add(chip);
      }
    }

    // Use a Column to arrange the two rows
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 8,
          children: firstRow,
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: secondRow,
        ),
      ],
    );
  }
}
