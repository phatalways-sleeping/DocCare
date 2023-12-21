// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/admin/management/v1/controller/create_staff_bloc.dart';
import 'package:views/src/screens/admin/management/v1/create_staff/dc_create_staff_screen2.dart';


class DCCreateStaffScreen1 extends StatefulWidget {
  const DCCreateStaffScreen1({super.key});

  @override
  State<DCCreateStaffScreen1> createState() => _DCCreateStaffScreen1State();
}

class _DCCreateStaffScreen1State extends State<DCCreateStaffScreen1> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateStaffBloc(
        SupabaseAuthenticationRepository.instance,
        NotificationManager.instance,
        SupabaseAdminRepository.instance,
      ),
      child: Scaffold(
        appBar: DCCustomerHeaderBar(
          title: 'Create staff',
          allowNavigateBack: true,
          onLeadingIconPressed: (context) {
            final createStaffBloc = context.read<CreateStaffBloc>();
            final state = createStaffBloc.state;
            if (state is CreateStaffLater) {
              createStaffBloc.add(const BackButtonPressedEvent());
            } else {
              Navigator.of(context).pop(); // Use this line to navigate back
            }
          },
        ),
        body: BlocBuilder<CreateStaffBloc, CreateStaffState>(
          builder: (context, state) {
            if (state is CreateStaffLoading) {
              BlocProvider.of<CreateStaffBloc>(context)
                  .add(const LoadingInitialStuffEvent());
            } else if (state is CreateStaffInitial) {
              return BodyScreen1(state: state);
            } else if (state is CreateStaffLater) {
              return DCCreateStaffScreen2(initialState: state);
            } // Add a default case or handle other states if needed
            return const Text('Create role successful');
          },
        ),
      ),
    );
  }
}

class BodyScreen1 extends StatelessWidget {
  const BodyScreen1({required this.state, super.key});
  final CreateStaffState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // child: BlocBuilder<CreateStaffBloc, CreateStaffState>(
      //   builder: (context, state) {
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Image.asset(
                  'assets/images/pic_5.png',
                  fit: BoxFit.cover,
                ),
                DCOutlinedWithHeadingTextFormField(
                  initialText: state.fullName,
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
                  initialText: state.email,
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
                  initialText: state.password,
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
                  initialText: state.tempBirthday,
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
                  onFocusChange: (context, focusNode) {
                    if (state.tempBirthday == '') {
                      return;
                    }
                    if (!focusNode.hasFocus) {
                      context.read<CreateStaffBloc>().add(
                            ValidateBirthdayInputEvent(
                              state.tempBirthday,
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(height: 16),
                DCOutlinedWithHeadingTextFormField(
                  initialText: state.phone,
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
                DCOutlinedWithHeadingTextFormField(
                  initialText: (state.startWorkingFrom == 1
                      ? ''
                      : state.startWorkingFrom.toString()),
                  heading: const Text('Working from'),
                  headingColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.onBackground,
                  color: context.colorScheme.onBackground,
                  borderRadius: 16,
                  keyboardType: TextInputType.number,
                  onChanged: (context, controller) =>
                      context.read<CreateStaffBloc>().add(
                            StartWorkingFromInputEvent(
                              int.tryParse(controller.text) ?? 1,
                            ),
                          ),
                ),
                const SizedBox(height: 16),
                DCAdminToggleButton(
                  elements: const ['Doctor', 'Receptionist'],
                  selectedElements: (state.role == 'Doctor'
                      ? [true, false].toList()
                      : [false, true].toList()),
                  title: 'Role',
                  onChanged: (context, controller) => {
                    context
                        .read<CreateStaffBloc>()
                        .add(RoleInputEvent(controller.text)),
                  },
                ),
                if (context.read<CreateStaffBloc>().state.role == 'Doctor')
                  Column(
                    children: [
                      Text(
                        'Specialization',
                        textAlign: TextAlign.justify,
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color:
                              context.colorScheme.onBackground.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownMenu<String>(
                        width: 350,
                        hintText: 'Specialization',
                        onSelected: (value) {
                          context
                              .read<CreateStaffBloc>()
                              .add(SpecializationIdInputEvent(value!));
                        },
                        initialSelection: state.specializationId,
                        dropdownMenuEntries: state.specializationList
                            .toSet() // Remove duplicates
                            .map(
                              (value) => DropdownMenuEntry<String>(
                                value: value,
                                label: value,
                              ),
                            )
                            .toList(),
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
                      ),
                    ],
                  )
                else
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
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
