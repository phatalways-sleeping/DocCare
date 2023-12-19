// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> showSuccessDialog({
  required BuildContext context,
}) =>
    showDialog(
      context: context,
      builder: (context) => _DialogTemplate(
        title: 'Request Sent!',
        description: 'The staff will inform the result to you soon.',
        svgAsset: DCSVGIcons.success,
        buttonText: 'Done',
        buttonColor: const Color(0xFF0EBE7F),
        svgBgColor: const Color(0xFFE7F8F2),
        onPressed: (context) => Navigator.of(context).pop(),
      ),
    );

Future<void> showErrorDialog({
  required BuildContext context,
  String? errorMessage,
}) =>
    showDialog(
      context: context,
      builder: (context) => _DialogTemplate(
        title: 'Request Failed!',
        description: errorMessage ?? 'Please try again later.',
        svgAsset: DCSVGIcons.error,
        buttonColor: context.colorScheme.error,
        buttonText: 'Back',
        svgBgColor: context.colorScheme.error,
        onPressed: (context) => Navigator.of(context).pop(),
      ),
    );

class _DialogTemplate extends StatelessWidget {
  const _DialogTemplate({
    required this.title,
    required this.description,
    required this.svgAsset,
    required this.svgBgColor,
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  final String title;
  final String description;
  final String svgAsset;
  final String buttonText;
  final Color svgBgColor;
  final Color buttonColor;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: context.width * 0.1,
          vertical: context.height * 0.20,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.03,
        ),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: svgBgColor,
              ),
              padding: const EdgeInsets.all(
                40,
              ),
              alignment: Alignment.center,
              child: SvgPicture.string(
                svgAsset,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            Text(
              title,
              style: context.textTheme.h1BoldPoppins.copyWith(
                fontSize: 20,
                color: context.colorScheme.tertiary,
              ),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            Text(
              description,
              style: context.textTheme.bodyRegularPoppins.copyWith(
                fontSize: 16,
                color: const Color(0xFF677294),
              ),
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            DCFilledButton(
              onPressed: onPressed,
              backgroundColor: buttonColor,
              fixedSize: Size(
                context.width * 0.75,
                context.height * 0.06,
              ),
              child: Text(
                buttonText,
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 18,
                  color: context.colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
