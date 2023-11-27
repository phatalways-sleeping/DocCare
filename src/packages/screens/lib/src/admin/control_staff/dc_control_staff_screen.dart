// ignore_for_file: public_member_api_docs

import 'package:administrator/administrator.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/controller/control_staff_bloc.dart';
import 'package:utility/utility.dart';

class DCControlStaffScreen extends StatefulWidget {
  const DCControlStaffScreen({super.key});

  @override
  State<DCControlStaffScreen> createState() => _DCControlStaffScreenState();
}

class _DCControlStaffScreenState extends State<DCControlStaffScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO(phucchuhoang): change appBar to custom app bar
    return Scaffold(
      appBar: DCAdminHeaderBar(
        headerBarTitle: ('Create staff'),
        allowNavigationBack: true,
      ),
      body: BlocProvider(
        create: (_) => ControlStaffBloc(NotificationManager.instance,
            SupabaseAdminControlStaffApiService.instance),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                              .read<ControlStaffBloc>()
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
                              .read<ControlStaffBloc>()
                              .add(FullNameInputEvent(controller.text)),
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
                              .read<ControlStaffBloc>()
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
                              .read<ControlStaffBloc>()
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
                              .read<ControlStaffBloc>()
                              .add(PhoneInputEvent(controller.text)),
                        ),
                        const SizedBox(height: 16),
                        DCOutlinedWithHeadingTextFormField(
                          heading: const Text('Role'),
                          headingColor: context.colorScheme.onSurface,
                          borderColor: context.colorScheme.onBackground,
                          color: context.colorScheme.onBackground,
                          borderRadius: 16,
                          keyboardType: TextInputType.text,
                          onChanged: (context, controller) => context
                              .read<ControlStaffBloc>()
                              .add(RoleInputEvent(controller.text)),
                        ),
                        const SizedBox(height: 16),
                        DCAdminToggleButton(
                          elements: ['Doctor', 'Receptionist'],
                          selectedElements: [true, false].toList(),
                          title: 'Role',
                          onChanged: (context, controller) => context
                              .read<ControlStaffBloc>()
                              .add(RoleInputEvent(controller.text)),
                        ),
                        Text(
                          'Specialization',
                          textAlign: TextAlign.justify,
                          style: context.textTheme.h6RegularPoppins.copyWith(
                            color: context.colorScheme.onBackground
                                .withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 16),
                        DCDropdownButton<String>(
                          borderRadius: 16,
                          dropdownWidth: context.width,
                          hintText: 'Specialization',
                          items: ['Ronaldo', 'Messi', 'Neymar', 'Bale'],
                          onItemSelected: (context, controller, selectedValue) {
                            // Pass context, controller, and selected value to your Bloc
                            context.read<ControlStaffBloc>().add(
                                  SpecializationIdInputEvent(controller.text),
                                );
                          },
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          child: Center(
                            child: DCButton(
                              text: 'Next',
                              onPressed: (context) =>
                                  context.read<ControlStaffBloc>().add(
                                        const NextButtonPressedEvent(),
                                      ),
                            ),
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
      ),
    );
  }
}
