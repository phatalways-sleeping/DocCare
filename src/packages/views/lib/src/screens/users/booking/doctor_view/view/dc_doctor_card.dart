// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:views/src/screens/users/booking/doctor_view/view/dc_storage_image.dart';

class DCDoctorCard extends StatelessWidget {
  const DCDoctorCard({
    required this.imgPath,
    required this.name,
    required this.speciality,
    required this.rating,
    required this.ratingCount,
    required this.onPressed,
    super.key,
  });

  final String imgPath;
  final String name;
  final String speciality;
  final double rating;
  final int ratingCount;

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
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black.withOpacity(0.1);
            }
            return Colors.white;
          },
        ),
      ),
      child: Row(
        children: [
          const DCStorageImage(imgPath: 'assets/images/doctor.png'),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  speciality,
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (int i = 1; i <= 5; i++)
                      if (i < rating)
                        Icon(
                          Icons.star,
                          size: context.width * 0.04,
                          color: Colors.yellow,
                        )
                      else
                        Icon(
                          Icons.star,
                          size: context.width * 0.04,
                          color: Colors.grey,
                        ),
                    const Spacer(),
                    Text(
                      '$rating',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '($ratingCount reviews)',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
