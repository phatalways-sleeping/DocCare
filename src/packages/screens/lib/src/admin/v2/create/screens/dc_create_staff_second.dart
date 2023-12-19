// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/admin/v2/create/widgets/config.dart';
import 'package:screens/src/admin/v2/create/widgets/dc_working_shift_widget.dart';

class DCCreateStaffSecond extends StatefulWidget {
  const DCCreateStaffSecond({super.key});

  @override
  State<DCCreateStaffSecond> createState() => _DCCreateStaffSecondState();
}

class _DCCreateStaffSecondState extends State<DCCreateStaffSecond> {
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
            children: [
              Image.asset(
                'assets/images/pic_5.png',
                fit: BoxFit.cover,
              ),
              Text(
                'Working shifts',
                style: context.textTheme.h1RegularPoppins.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: context.colorScheme.tertiary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DCWorkingShiftWidget(
                onChangedWeekDay: (context) {},
                onChangedStartPeriod: (context) {},
                onChangedEndPeriod: (context) {},
              ),
              gap,
              DCWorkingShiftWidget(
                onChangedWeekDay: (context) {},
                onChangedStartPeriod: (context) {},
                onChangedEndPeriod: (context) {},
              ),
              gap,
              DCFilledButton(
                onPressed: (context) {},
                fixedSize: Size(
                  context.width * 0.8,
                  50,
                ),
                borderRadius: BorderRadius.circular(20),
                backgroundColor: context.colorScheme.secondary,
                child: Text(
                  'Add more',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
              ),
              SizedBox(
                height: context.height * 0.1,
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
                    'Next',
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