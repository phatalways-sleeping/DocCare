// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class ToBeTakenSelector extends StatefulWidget {
  const ToBeTakenSelector({
    super.key,
  });

  @override
  State<ToBeTakenSelector> createState() => _ToBeTakenSelectorState();
}

class _ToBeTakenSelectorState extends State<ToBeTakenSelector> {
  final List<String> _timesToTake = ['Before Meal', 'After Meal'];
  final List<bool> _selectedTimes = [false, false];

  @override
  Widget build(BuildContext context) {
    // Calculate the width and height based on the screen size
    final chipWidth = context.width * 0.43;
    final chipHeight = context.height * 0.05;

    // Create two lists of widgets for each row
    final firstRow = <Widget>[];

    for (var i = 0; i < _timesToTake.length; i++) {
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
                _selectedTimes[1 - i] = false;
              });
            },
            borderRadius: BorderRadius.circular(30),
            child: Center(
              child: Text(
                _timesToTake[i],
                style: context.textTheme.h6BoldPoppins.copyWith(
                  fontSize: 16,
                  color: context.colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ),
      );

      firstRow.add(chip);
    }

    // Use a Column to arrange the two rows
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: 8,
          children: firstRow,
        ),
      ],
    );
  }
}
