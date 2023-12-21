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

  final String imgPath;
  final String name;
  final DateTime dateAbsent;
  final void Function(BuildContext context) onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ButtonStyle(
        maximumSize: MaterialStateProperty.all(
          Size(
            double.infinity,
            context.height * 0.14,
          ),
        ),
        padding: MaterialStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: context.width * 0.03,
            vertical: context.height * 0.01,
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return context.colorScheme.tertiary.withOpacity(0.5);
          } else {
            return Colors.white;
          }
        }),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        shadowColor: const MaterialStatePropertyAll(
          Colors.black12,
        ),
        elevation: const MaterialStatePropertyAll(
          8,
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