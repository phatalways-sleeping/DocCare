// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCCircularItem extends StatelessWidget {
  const DCCircularItem({
    required this.onPressed,
    super.key,
    this.isSelected = false,
    this.isAvailable = false,
    this.title = '',
    this.subtitle = '',
  }) : assert(
          isSelected == false || isAvailable == true,
          'isSelected cannot be true if isAvailable is false',
        );

  final bool isSelected;
  final bool isAvailable;
  final String title;
  final String subtitle;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isAvailable) {
          print('isAvailable');
          onPressed(context);
        }
      },
      highlightColor: Colors.white,
      splashColor: Colors.white,
      child: Container(
        width: context.width * 0.2,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? context.colorScheme.primary
              : context.colorScheme.primary.withOpacity(0.3),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: context.textTheme.bodyRegularPoppins.copyWith(
                fontSize: 12,
                color: isSelected
                    ? Colors.black
                    : isAvailable
                        ? Colors.black
                        : context.colorScheme.primary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              subtitle,
              style: context.textTheme.bodyRegularPoppins.copyWith(
                fontSize: 12,
                color: isSelected
                    ? Colors.black
                    : isAvailable
                        ? Colors.black
                        : context.colorScheme.primary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
