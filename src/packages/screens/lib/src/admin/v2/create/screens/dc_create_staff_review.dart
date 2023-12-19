// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/admin/v2/create/widgets/config.dart';
import 'package:screens/src/admin/v2/create/widgets/dc_content_line.dart';

class DCCreateStaffReview extends StatefulWidget {
  const DCCreateStaffReview({super.key});

  @override
  State<DCCreateStaffReview> createState() => _DCCreateStaffReviewState();
}

class _DCCreateStaffReviewState extends State<DCCreateStaffReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCAdminHeaderBar(
        allowNavigationBack: true,
        onLeadingIconPressed: (context) {},
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
          ).copyWith(
            bottom: context.height * 0.08,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/pic_4.png',
                fit: BoxFit.cover,
              ),
              const DCContentLine(
                title: 'Full name',
                content: 'John Doe',
              ),
              gap,
              const DCContentLine(
                title: 'Email',
                content: 'johndoe@gmail.com',
              ),
              gap,
              const DCContentLine(
                title: 'Birthday',
                content: '21/12/1990',
              ),
              gap,
              const DCContentLine(
                title: 'Phone number',
                content: '+1 234 567 89 00',
              ),
              gap,
              const DCContentLine(
                title: 'Role',
                content: 'Doctor',
              ),
              gap,
              const DCContentLine(
                title: 'Speciality',
                content: 'Dentist',
              ),
              gap,
              DCContentLine.title(
                title: 'Working shifts',
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: context.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DCContentLine.workingShift(
                      weekDay: 'Monday',
                      startPeriod: '1',
                      endPeriod: '2',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: context.height * 0.05,
              ),
              Material(
                color: context.colorScheme.background,
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: DCFilledButton(
                  onPressed: (context) {},
                  fixedSize: Size(
                    context.width * 0.9,
                    50,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  backgroundColor: context.colorScheme.secondary,
                  child: Text(
                    'Create',
                    style: context.textTheme.bodyRegularPoppins.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.tertiary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
