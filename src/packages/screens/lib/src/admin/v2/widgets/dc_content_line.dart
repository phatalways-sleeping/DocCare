// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCContentLine extends StatelessWidget {
  const DCContentLine({
    required this.title,
    required this.content,
    super.key,
  });

  factory DCContentLine.title({
    required String title,
  }) =>
      DCContentLine(
        title: title,
        content: '',
      );

  factory DCContentLine.workingShift({
    required String weekDay,
    required String startPeriod,
    required String endPeriod,
  }) =>
      DCContentLine(
        title: weekDay,
        content: '$startPeriod to $endPeriod',
      );

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$title: ',
            style: context.textTheme.bodyRegularPoppins.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: context.colorScheme.tertiary,
            ),
          ),
          TextSpan(
            text: content,
            style: context.textTheme.bodyRegularPoppins.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
