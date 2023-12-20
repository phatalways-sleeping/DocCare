// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/v2/create/controllers/create_staff/create_staff_bloc.dart';
import 'package:screens/src/admin/v2/create/controllers/screen/screen_bloc.dart';
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
              BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                selector: (state) => state.fullName,
                builder: (context, state) {
                  return DCOutlinedWithHeadingTextFormField(
                    initialText: state,
                    onChanged: (context, controller) =>
                        context.read<StaffCreationBloc>().add(
                              CreateStaffNameChangedEvent(
                                controller.text,
                              ),
                            ),
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
                  );
                },
              ),
              gap,
              BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                selector: (state) => state.email,
                builder: (context, state) {
                  return DCOutlinedWithHeadingTextFormField(
                    initialText: state,
                    onChanged: (context, controller) =>
                        context.read<StaffCreationBloc>().add(
                              CreateStaffEmailChangedEvent(
                                controller.text,
                              ),
                            ),
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
                  );
                },
              ),
              gap,
              BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                selector: (state) => state.password,
                builder: (context, state) {
                  return DCOutlinedWithHeadingTextFormField(
                    onChanged: (context, controller) =>
                        context.read<StaffCreationBloc>().add(
                              CreateStaffPasswordChangedEvent(
                                controller.text,
                              ),
                            ),
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
                  );
                },
              ),
              gap,
              BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                selector: (state) => state.birthdate,
                builder: (context, state) {
                  return DCOutlinedWithHeadingTextFormField(
                    onChanged: (context, controller) =>
                        context.read<StaffCreationBloc>().add(
                              CreateStaffBirthdateChangedEvent(
                                controller.text,
                              ),
                            ),
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
                  );
                },
              ),
              gap,
              BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                selector: (state) => state.phoneNumber,
                builder: (context, state) {
                  return DCOutlinedWithHeadingTextFormField(
                    onChanged: (context, controller) =>
                        context.read<StaffCreationBloc>().add(
                              CreateStaffPhoneNumberChangedEvent(
                                controller.text,
                              ),
                            ),
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
                  );
                },
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
              BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                selector: (state) => state.role,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DCSwitchableButton(
                        text: 'Doctor',
                        filled: state == 'Doctor',
                        onPressed: (context) => context
                            .read<StaffCreationBloc>()
                            .add(const CreateStaffRoleChangedEvent('Doctor')),
                      ),
                      SizedBox(
                        width: context.width * 0.05,
                      ),
                      DCSwitchableButton(
                        text: 'Receptionist',
                        filled: state == 'Receptionist',
                        onPressed: (context) =>
                            context.read<StaffCreationBloc>().add(
                                  const CreateStaffRoleChangedEvent(
                                    'Receptionist',
                                  ),
                                ),
                      ),
                    ],
                  );
                },
              ),
              if (context.watch<StaffCreationBloc>().state.role ==
                  'Doctor') ...[
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
                BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                  selector: (state) => state.specialization,
                  builder: (context, state) {
                    return DCSpecialityButton(
                      onPressed: (context, value) => context
                          .read<StaffCreationBloc>()
                          .add(CreateStaffSpecializationChangedEvent(value)),
                      hintText: 'Select the speciality',
                      initialValue: state.isEmpty ? null : state,
                      width: context.width * 0.9,
                      future: Future.delayed(
                        const Duration(seconds: 2),
                        () => specialityData,
                      ),
                    );
                  },
                ),
              ],
              gap,
              Material(
                color: context.colorScheme.background,
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child:
                    BlocSelector<StaffCreationBloc, CreateStaffState, String>(
                  selector: (state) => state.role,
                  builder: (context, state) {
                    return DCFilledButton(
                      onPressed: (context) {
                        if (state == 'Receptionist') {
                          return context.read<ScreenBloc>().add(
                                const NavigateToThirdScreen(),
                              );
                        }
                        context.read<ScreenBloc>().add(
                              const NavigateToSecondScreen(),
                            );
                      },
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
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
