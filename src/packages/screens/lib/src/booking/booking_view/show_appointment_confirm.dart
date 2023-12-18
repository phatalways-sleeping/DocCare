// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

Future<bool> showAppointmentConfirm({
  required BuildContext context,
  required String time,
  required String symptom,
  required DateTime date,
  String? doctorName,
  String? speciality,
}) async =>
    showDialog<bool>(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.05,
          vertical: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: context.width * 0.05,
          vertical: context.height * 0.15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.colorScheme.background,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Please check your appointment request before submitted',
                style: context.textTheme.h3BoldPoppins.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'New Appointment',
                style: context.textTheme.bodyBoldPoppins.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 6,
              ),
              if (doctorName != null)
                Text(
                  'You have book for an appointment at $time on ${date.day}/${date.month}/${date.year} with Dr.${doctorName.split('Dr.').last}.',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                )
              else
                Text(
                  'You have book for an appointment at $time on ${date.day}/${date.month}/${date.year} with our doctor in $speciality.',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Symptoms',
                style: context.textTheme.bodyBoldPoppins.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                symptom.isEmpty ? 'None' : symptom,
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Note',
                style: context.textTheme.bodyBoldPoppins.copyWith(fontSize: 18),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Please if you’re pleasant with this arrangement, press ‘Confirm’ otherwise ‘Cancel’.\nIf you have not chosen any doctor, we will assign our best doctor for you.',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DCFilledButton(
                    onPressed: (context) => Navigator.pop(context, false),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    fixedSize: Size(
                      context.width * 0.35,
                      40,
                    ),
                    backgroundColor: context.colorScheme.error,
                    child: Text(
                      'Cancel',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  DCFilledButton(
                    onPressed: (context) => Navigator.pop(context, true),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    fixedSize: Size(
                      context.width * 0.35,
                      40,
                    ),
                    backgroundColor: const Color(0xFF8BF0B4),
                    child: Text(
                      'Confirm',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ).then((value) => value ?? false);
