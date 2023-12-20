// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future<void> showStaffAddedDialog({
  required BuildContext context,
  required String role,
  String? message,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Scaffold(
        backgroundColor: context.colorScheme.background.withOpacity(0.5),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.colorScheme.background,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: context.height * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE7F8F2),
                  ),
                  padding: const EdgeInsets.all(
                    50,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    DCSVGIcons.success,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                Text(
                  'Successful!',
                  style: context.textTheme.h3BoldPoppins.copyWith(
                    fontSize: 24,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message ?? 'The $role has been added to the system.',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                DCFilledButton(
                  onPressed: (context) => Navigator.of(context).pop(),
                  backgroundColor: context.colorScheme.primary,
                  fixedSize: Size(
                    context.width * 0.8,
                    50,
                  ),
                  child: Text(
                    'Done',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      fontSize: 16,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Future<void> showAddingOperationFailure({
  required BuildContext context,
  String? message,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Scaffold(
        backgroundColor: context.colorScheme.background.withOpacity(0.5),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.25,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: context.colorScheme.background,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: context.height * 0.03,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.error,
                  ),
                  padding: const EdgeInsets.all(
                    50,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.string(
                    DCSVGIcons.error,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: context.height * 0.04,
                ),
                Text(
                  'Request Failed!',
                  style: context.textTheme.h3BoldPoppins.copyWith(
                    fontSize: 24,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message ?? 'Please try again!',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                DCFilledButton(
                  onPressed: (context) => Navigator.of(context).pop(),
                  backgroundColor: context.colorScheme.error,
                  fixedSize: Size(
                    context.width * 0.8,
                    50,
                  ),
                  child: Text(
                    'Back',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      fontSize: 16,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
