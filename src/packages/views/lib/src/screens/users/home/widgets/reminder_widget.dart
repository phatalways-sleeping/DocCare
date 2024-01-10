// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({
    required this.content,
    required this.timeLeft,
    required this.appointmentTime,
    super.key,
  });

  final String content;
  final String timeLeft;
  final String appointmentTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              SvgPicture.string(
                DCSVGIcons.notificationsIcon,
                width: 30,
                height: 30,
              ),
              const SizedBox(width: 8),
              Text(
                'Upcoming',
                style: context.textTheme.h6BoldPoppins.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                timeLeft,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                appointmentTime,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
