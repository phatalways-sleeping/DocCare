// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:views/src/screens/receptionist/absent/utils.dart';
import 'package:views/src/widgets/dc_storage_image.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    required this.imgPath,
    required this.name,
    required this.dateAbsent,
    required this.onPressed,
    super.key,
  });

  final String? imgPath;
  final String name;
  final DateTime dateAbsent;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(2),
        fixedSize: MaterialStateProperty.all<Size>(
          Size(
            context.width * 0.94,
            context.height * 0.15,
          ),
        ),
        surfaceTintColor: MaterialStateProperty.all<Color>(
          Colors.transparent,
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            horizontal: context.width * 0.03,
            vertical: 10,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          context.colorScheme.background,
        ),
      ),
      child: Row(
        children: [
          DCStorageImage(
            imgPath: imgPath,
          ),
          SizedBox(
            width: context.width * 0.03,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: context.textTheme.h1BoldPoppins.copyWith(
                    fontSize: 20,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                Flexible(
                  child: Wrap(
                    children: [
                      Text(
                        '''Absent on ${mapMonth(dateAbsent.month)} ${dateAbsent.day}${getPostFix(dateAbsent.day)}, ${dateAbsent.year}''',
                        style: context.textTheme.bodyRegularPoppins.copyWith(
                          fontSize: 16,
                          color: context.colorScheme.tertiary,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
