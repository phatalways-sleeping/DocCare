// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:views/src/screens/users/booking/doctor_view/view/dc_doctor_card.dart';

Future<void> showSuccessfulWithDoctorDialog({
  required BuildContext context,
  required Map<String, dynamic> doctorData,
  required DateTime dateSelected,
  required String timeSelected,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
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
            horizontal: context.width * 0.03,
            vertical: 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (doctorData.isNotEmpty)
                DCDoctorCard(
                  imgPath: doctorData['imgPath'] as String,
                  name: doctorData['name'] as String,
                  speciality: doctorData['speciality'] as String,
                  rating: (doctorData['rating'] as num).toDouble(),
                  ratingCount: doctorData['ratingCount'] as int,
                  onPressed: (context) {},
                ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Booking successful!',
                style: context.textTheme.h3BoldPoppins.copyWith(
                  fontSize: 18,
                  color: context.colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your appointment has been booked successfully.',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your section shall start at $timeSelected on ${dateSelected.year}/${dateSelected.month}/${dateSelected.day}.',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please come to the clinic on time. If you have any questions, please contact us at +84 123 456 789.',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: context.height * 0.04,
              ),
              DCFilledButton(
                onPressed: (context) => Navigator.of(context).pop(),
                backgroundColor: context.colorScheme.primary,
                fixedSize: Size(
                  context.width * 0.8,
                  50,
                ),
                child: Text(
                  'Come back to home',
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 18,
                    color: context.colorScheme.tertiary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Future<void> showSuccessfulDialog({
  required BuildContext context,
  required DateTime dateSelected,
  required String timeSelected,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
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
                'Thank You!',
                style: context.textTheme.h3BoldPoppins.copyWith(
                  fontSize: 20,
                  color: context.colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'We have received your appointment request.',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your section shall start at $timeSelected on ${dateSelected.year}/${dateSelected.month}/${dateSelected.day}.',
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: context.height * 0.10,
              ),
              DCFilledButton(
                onPressed: (context) => Navigator.of(context).pop(),
                backgroundColor: const Color(0xFF0EBE7F),
                fixedSize: Size(
                  context.width * 0.8,
                  50,
                ),
                child: Text(
                  'I understand',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Future<void> showFailedDialog({
  required BuildContext context,
}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Container(
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
                'Opps!',
                style: context.textTheme.h3BoldPoppins.copyWith(
                  fontSize: 20,
                  color: context.colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please try again!',
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
    );
