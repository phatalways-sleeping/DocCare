// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/absent/receptionist/utils.dart';

enum RequestResponse { accept, reject, unknown }

Future<RequestResponse> showRequestDialog({
  required BuildContext context,
  required String title,
  required String doctorName,
  required DateTime absentDate,
  required String messageReasons,
  required String messageNotes,
}) =>
    showDialog<RequestResponse>(
      context: context,
      builder: (context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: context.height * 0.15,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.03,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: context.colorScheme.background,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Text(
                        'Absence Request',
                        style: context.textTheme.h1BoldPoppins.copyWith(
                          fontSize: 20,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.colorScheme.tertiary,
                                width: 2,
                              ),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.close,
                              color: context.colorScheme.tertiary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  child: Text(
                    'Dr.$doctorName requests for absence on from work',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      fontSize: 16,
                      color: context.colorScheme.tertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Details',
                  style: context.textTheme.h1BoldPoppins.copyWith(
                    fontSize: 18,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Absent on: ${mapMonth(absentDate.month)} ${absentDate.day}${getPostFix(absentDate.day)}, ${absentDate.year}',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Reasons: $messageReasons',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Notes: $messageNotes',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: context.colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DCFilledButton(
                      onPressed: (context) => Navigator.of(context).pop(
                        RequestResponse.reject,
                      ),
                      backgroundColor: context.colorScheme.error,
                      fixedSize: Size(
                        context.width * 0.4,
                        45,
                      ),
                      child: Text(
                        'Reject',
                        style: context.textTheme.bodyRegularPoppins.copyWith(
                          fontSize: 16,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.03,
                    ),
                    DCFilledButton(
                      onPressed: (context) => Navigator.of(context).pop(
                        RequestResponse.accept,
                      ),
                      fixedSize: Size(
                        context.width * 0.4,
                        45,
                      ),
                      backgroundColor: context.colorScheme.primary,
                      child: Text(
                        'Confirm',
                        style: context.textTheme.bodyRegularPoppins.copyWith(
                          fontSize: 16,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ).then(
      (value) => value ?? RequestResponse.unknown,
    );
