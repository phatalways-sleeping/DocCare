// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHealthCard extends StatelessWidget {
  const CustomHealthCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.currentValue,
    required this.unit,
    required this.lastCheckupValue,
    super.key,
  });

  final String title;
  final String icon;
  final Color color;
  final String currentValue;
  final String unit;
  final String lastCheckupValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 22, 4, 0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.tertiary.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0.9),
          ],
          center: Alignment.topLeft,
          radius: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(
                icon,
                width: 25,
                height: 25,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: context.textTheme.h6BoldPoppins.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              currentValue,
              style: context.textTheme.h6BoldPoppins.copyWith(fontSize: 30),
            ),
          ),
          Center(
            child: Text(
              unit,
              style: context.textTheme.h6RegularPoppins.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last checkup: ',
                style: context.textTheme.h6RegularPoppins.copyWith(
                  fontSize: 14,
                  color: context.colorScheme.onSecondary.withOpacity(0.5),
                ),
              ),
              Text(
                lastCheckupValue,
                style: context.textTheme.h6BoldPoppins.copyWith(
                  fontSize: 14,
                  color: context.colorScheme.onSecondary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
