// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/admin/v2/create/widgets/config.dart';
import 'package:screens/src/admin/v2/create/widgets/dc_speciality_button.dart';
import 'package:screens/src/admin/v2/create/widgets/dc_switchable_button.dart';



class DCCreateStaffEntrance extends StatefulWidget {
  const DCCreateStaffEntrance({super.key});

  @override
  State<DCCreateStaffEntrance> createState() => _DCCreateStaffEntranceState();
}

class _DCCreateStaffEntranceState extends State<DCCreateStaffEntrance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCAdminHeaderBar(),
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
              gap,
              DCOutlinedWithHeadingTextFormField(
                heading: Text(
                  'Full name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: 'Enter the full name of the staff',
                borderRadius: 12,
                textAlign: TextAlign.center,
                maxLines: 1,
                keyboardType: TextInputType.name,
              ),
              gap,
              DCOutlinedWithHeadingTextFormField(
                heading: Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: 'Enter the email of the staff',
                borderRadius: 12,
                textAlign: TextAlign.center,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
              ),
              gap,
              DCOutlinedWithHeadingTextFormField(
                heading: Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: "Enter the account's password",
                borderRadius: 12,
                textAlign: TextAlign.center,
                maxLines: 1,
                keyboardType: TextInputType.visiblePassword,
              ),
              gap,
              DCOutlinedWithHeadingTextFormField(
                heading: Text(
                  'Birthdate',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: 'DD/MM/YYYY',
                borderRadius: 12,
                textAlign: TextAlign.center,
                maxLines: 1,
                keyboardType: TextInputType.datetime,
              ),
              gap,
              DCOutlinedWithHeadingTextFormField(
                heading: Text(
                  'Phone number',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: context.colorScheme.tertiary,
                  ),
                ),
                hintText: 'Enter the phone number of the staff',
                borderRadius: 12,
                textAlign: TextAlign.center,
                maxLines: 1,
                keyboardType: TextInputType.phone,
              ),
              gap,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Role',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    color: context.colorScheme.tertiary,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DCSwitchableButton(
                    text: 'Doctor',
                    filled: false,
                    onPressed: (context) {},
                  ),
                  SizedBox(
                    width: context.width * 0.05,
                  ),
                  DCSwitchableButton(
                    text: 'Receptionist',
                    filled: true,
                    onPressed: (context) {},
                  ),
                ],
              ),
              gap,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Doctor's speciality",
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    color: context.colorScheme.tertiary,
                    fontSize: 18,
                  ),
                ),
              ),
              gap,
              DCSpecialityButton(
                onPressed: (context) {
                  
                },
                hintText: 'Select the speciality',
                width: context.width * 0.9,
                future: Future.delayed(
                  const Duration(seconds: 2),
                  () => specialityData,
                ),
              ),
              gap,
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
