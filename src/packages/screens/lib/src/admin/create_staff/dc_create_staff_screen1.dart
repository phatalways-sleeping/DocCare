// ignore_for_file: public_member_api_docs

import 'dart:html';

import 'package:administrator/administrator.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/controller/create_staff_bloc.dart';
import 'package:utility/utility.dart';
import 'package:screens/screens.dart';

class DCCreateStaffScreen1 extends StatefulWidget {
  const DCCreateStaffScreen1({super.key});

  @override
  State<DCCreateStaffScreen1> createState() => _DCCreateStaffScreen1State();
}

class _DCCreateStaffScreen1State extends State<DCCreateStaffScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCAdminHeaderBar(
        headerBarTitle: ('Create staff'),
        allowNavigationBack: true,
      ),
      body: BlocProvider(
        create: (_) => CreateStaffBloc(NotificationManager.instance,
            SupabaseAdminControlStaffApiService.instance),
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: BodyWidget()),
          ],
        ),
      ),
    );
  }
}

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateStaffBloc, CreateStaffState>(
      builder: (context, state) {
        if (state is CreateStaffInitial) {
          return BodyScreen1();
        } else if (state is CreateStaffLoading) {
          return DCCreateStaffScreen2();
        } // Add a default case or handle other states if needed
        return Container(child: Text('Adasdadwas'));
      },
    );
  }
}

class BodyScreen1 extends StatelessWidget {
  BodyScreen1({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // child: BlocBuilder<CreateStaffBloc, CreateStaffState>(
        //   builder: (context, state) {
        child: Column(
          children: [
            Image.asset(
              'assets/images/pic_5.png',
              fit: BoxFit.cover,
            ),
            DCOutlinedWithHeadingTextFormField(
              heading: const Text('Full Name'),
              headingColor: context.colorScheme.onSurface,
              borderColor: context.colorScheme.onBackground,
              color: context.colorScheme.onBackground,
              borderRadius: 16,
              keyboardType: TextInputType.name,
              onChanged: (context, controller) => context
                  .read<CreateStaffBloc>()
                  .add(FullNameInputEvent(controller.text)),
            ),
            const SizedBox(height: 16),
            DCOutlinedWithHeadingTextFormField(
              heading: const Text('Email'),
              headingColor: context.colorScheme.onSurface,
              borderColor: context.colorScheme.onBackground,
              color: context.colorScheme.onBackground,
              borderRadius: 16,
              keyboardType: TextInputType.emailAddress,
              onChanged: (context, controller) => context
                  .read<CreateStaffBloc>()
                  .add(EmailInputEvent(controller.text)),
            ),
            const SizedBox(height: 16),
            DCOutlinedWithHeadingTextFormField(
              heading: const Text('Password'),
              headingColor: context.colorScheme.onSurface,
              borderColor: context.colorScheme.onBackground,
              color: context.colorScheme.onBackground,
              borderRadius: 16,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (context, controller) => context
                  .read<CreateStaffBloc>()
                  .add(PasswordInputEvent(controller.text)),
            ),
            const SizedBox(height: 16),
            DCOutlinedWithHeadingTextFormField(
              heading: const Text('Birthday'),
              hintText: 'dd/mm/yyyy',
              headingColor: context.colorScheme.onSurface,
              borderColor: context.colorScheme.onBackground,
              color: context.colorScheme.onBackground,
              borderRadius: 16,
              keyboardType: TextInputType.datetime,
              onChanged: (context, controller) => context
                  .read<CreateStaffBloc>()
                  .add(BirthdayInputEvent(controller.text)),
            ),
            const SizedBox(height: 16),
            DCOutlinedWithHeadingTextFormField(
              heading: const Text('Phone number'),
              headingColor: context.colorScheme.onSurface,
              borderColor: context.colorScheme.onBackground,
              color: context.colorScheme.onBackground,
              borderRadius: 16,
              keyboardType: TextInputType.phone,
              onChanged: (context, controller) => context
                  .read<CreateStaffBloc>()
                  .add(PhoneInputEvent(controller.text)),
            ),
            const SizedBox(height: 16),
            DCAdminToggleButton(
              elements: ['Doctor', 'Receptionist'],
              selectedElements: [true, false].toList(),
              title: 'Role',
              onChanged: (context, controller) => {
                context
                    .read<CreateStaffBloc>()
                    .add(RoleInputEvent(controller.text)),
              },
            ),
            if (context.read<CreateStaffBloc>().state.roleSelected == 'Doctor')
              Column(
                children: [
                  Text(
                    'Specialization',
                    textAlign: TextAlign.justify,
                    style: context.textTheme.h6RegularPoppins.copyWith(
                      color: context.colorScheme.onBackground.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DCDropdownButton<String>(
                    borderRadius: 16,
                    dropdownWidth: context.width,
                    hintText: 'Specialization',
                    items: ['Ronaldo', 'Messi', 'Neymar', 'Bale'],
                    onItemSelected: (context, controller, selectedValue) {
                      context.read<CreateStaffBloc>().add(
                            SpecializationIdInputEvent(
                                selectedValue.toString()),
                          );
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    child: Center(
                      child: DCButton(
                        text: 'Next',
                        onPressed: (context) =>
                            context.read<CreateStaffBloc>().add(
                                  const NextButtonPressedEvent(),
                                ),
                      ),
                    ),
                  )
                ],
              )
            else if (context.read<CreateStaffBloc>().state.role ==
                'Receptionist')
              Column(
                children: [
                  const SizedBox(height: 16),
                  InkWell(
                    child: Center(
                      child: DCButton(
                        text: 'Submit',
                        onPressed: (context) =>
                            context.read<CreateStaffBloc>().add(
                                  const CreateStaffButtonPressedEvent(),
                                ),
                      ),
                    ),
                  )
                ],
              ),
          ],
        )
        // ),
        );
  }
}
