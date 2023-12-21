// ignore_for_file: public_member_api_docs

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCSwitchableButton extends StatelessWidget {
  const DCSwitchableButton({
    required this.text,
    required this.filled,
    required this.onPressed,
    super.key,
  });

  final String text;
  final bool filled;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        filled ? context.colorScheme.error : context.colorScheme.background;
    final borderColor = filled ? Colors.transparent : context.colorScheme.error;
    return Expanded(
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(color: borderColor),
            ),
          ),
          fixedSize: MaterialStateProperty.all(
            Size(
              context.width * 0.4,
              context.height * 0.05,
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 20,
            ),
          ),
          alignment: Alignment.center,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
