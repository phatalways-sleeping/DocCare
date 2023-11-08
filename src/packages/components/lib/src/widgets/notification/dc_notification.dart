// ignore_for_file: public_member_api_docs
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DCNotification extends StatelessWidget {
  const DCNotification({
    required this.title,
    required this.message,
    required this.notificationTime,
    super.key,
  });

  final String title;
  final String message;
  final DateTime notificationTime;

  @override
  Widget build(BuildContext context) {
    final timeDisplay = DateFormat('hh:mm a, d MMM y').format(notificationTime);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          context.colorScheme.quinary,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.all(16),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification clicked'),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align text to the left side
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
              fontSize: 20,
              color: context.colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontFamily: context.textTheme.h6RegularPoppins.fontFamily,
              color: context.colorScheme.onPrimary,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                timeDisplay,
                style: TextStyle(
                  fontFamily: context.textTheme.h6RegularPoppins.fontFamily,
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
