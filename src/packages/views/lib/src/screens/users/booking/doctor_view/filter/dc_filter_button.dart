// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCSpecialtyButton extends StatelessWidget {
  const DCSpecialtyButton({
    required this.isSelected,
    required this.specialty,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 5,
    ),
    super.key,
  });
  final bool isSelected;
  final String specialty;
  final void Function(BuildContext context) onPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsets>(
          padding,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: isSelected
                ? context.colorScheme.error
                : context.colorScheme.secondary,
          ),
        ),
        surfaceTintColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        backgroundColor: MaterialStatePropertyAll(
          isSelected ? context.colorScheme.error : Colors.white,
        ),
        alignment: Alignment.center,
      ),
      child: Text(
        specialty,
        style: context.textTheme.bodyRegularPoppins.copyWith(
          fontSize: 14,
          color: isSelected ? Colors.black : context.colorScheme.secondary,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class DCRatingButton extends StatelessWidget {
  const DCRatingButton({
    required this.isSelected,
    required this.rating,
    required this.onPressed,
    super.key,
  });
  final bool isSelected;
  final String rating;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            horizontal: 16,
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
            context.width * 0.20,
            30,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: isSelected
                ? context.colorScheme.error
                : context.colorScheme.secondary,
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          isSelected ? context.colorScheme.error : Colors.white,
        ),
        alignment: Alignment.center,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: isSelected ? Colors.black : context.colorScheme.secondary,
            size: 14,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            rating,
            style: context.textTheme.bodyRegularPoppins.copyWith(
              fontSize: 14,
              color: isSelected ? Colors.black : context.colorScheme.secondary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
