// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCMedicine extends StatelessWidget {
  const DCMedicine({
    required this.medicineName,
    required this.details,
    required this.amount,
    super.key,
  });

  final String medicineName;
  final String details;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.green,
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SvgPicture.string(
              DCSVGIcons.pill,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          medicineName,
                          style: context.textTheme.h6RegularPoppins.copyWith(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.string(
                          DCSVGIcons.deleteMedicine,
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          details,
                          style: context.textTheme.h6RegularPoppins.copyWith(
                            fontSize: 14,
                            color: context.colorScheme.onSecondary
                                .withOpacity(0.5),
                          ),
                        ),
                      ),
                      Text(
                        amount,
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          fontSize: 14,
                          color:
                              context.colorScheme.onSecondary.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
