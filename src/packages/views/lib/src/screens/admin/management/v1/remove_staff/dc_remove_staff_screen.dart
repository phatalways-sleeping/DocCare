// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:components/components.dart';
import 'package:controllers/controllers.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility/utility.dart';
import 'package:views/src/screens/admin/management/v1/remove_controller/remove_staff_bloc.dart';

class DCRemoveStaffScreen extends StatefulWidget {
  const DCRemoveStaffScreen({super.key});

  @override
  State<DCRemoveStaffScreen> createState() => _DCRemoveStaffScreenState();
}

class _DCRemoveStaffScreenState extends State<DCRemoveStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return buildScaffold();
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: buildAppBar(),
      body: BlocProvider(
        create: (_) => RemoveStaffBloc(
          NotificationManager.instance,
          SupabaseAdminRepository(),
        ),
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Body()),
          ],
        ),
      ),
    );
  }

  DCAdminHeaderBar buildAppBar() {
    return DCAdminHeaderBar(
      headerBarTitle: 'Remove staff',
      allowNavigationBack: true,
      onLeadingIconPressed: (context) {
        Navigator.pop(context);
      },
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoveStaffBloc, RemoveStaffState>(
      builder: (context, state) {
        if (state is RemoveStaffLoading) {
          BlocProvider.of<RemoveStaffBloc>(context)
              .add(const RemoveStaffLoadingEvent());
        }
        if (state is RemoveStaffInitial) return BodyScreen(state: state);
        return const Text('Delete role successful');
      },
    );
  }
}

class BodyScreen extends StatelessWidget {
  final RemoveStaffState state;
  BodyScreen({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> emails = (state.role == 'Doctor')
        ? state.allDoctorEmail
        : state.allReceptionistEmail;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // child: BlocBuilder<CreateStaffBloc, CreateStaffState>(
      //   builder: (context, state) {
      child: Column(
        children: [
          const Text(
            'Select role',
            // textScaler: TextScaler.linear(1.5),
          ),
          DropdownMenu<String>(
            onSelected: (value) {
              context.read<RemoveStaffBloc>().add(RoleInputEvent(value!));
            },
            initialSelection: state.role,
            dropdownMenuEntries: const [
              DropdownMenuEntry<String>(value: 'Doctor', label: 'Doctor'),
              DropdownMenuEntry<String>(
                value: 'Receptionist',
                label: 'Receptionist',
              ),
            ],
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
                .read<RemoveStaffBloc>()
                .add(EmailInputEvent(controller.text)),
          ),

          //Create a list of email here
          Column(
            children: emails
                .where((email) => email.contains(state.email))
                .take(10)
                .map(
                  (email) => DCSelectableButton(
                    text: email,
                    onClick: () => {
                      context
                          .read<RemoveStaffBloc>()
                          .add(SelectEmailEvent(email)),
                    },
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 16),
          InkWell(
            child: Center(
              child: DCButton(
                backgroundColor: Colors.red[500],
                widthFactor: 0.9,
                text: 'Delete',
                onPressed: (context) => context.read<RemoveStaffBloc>().add(
                      const RemoveStaffButtonPressedEvent(),
                    ),
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}

class DCSelectableButton extends StatelessWidget {
  const DCSelectableButton({
    required this.text,
    required this.onClick,
    super.key,
  });
  final String text;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoveStaffBloc, RemoveStaffState>(
      builder: (context, state) {
        var isSelected = state.selectedEmails.contains(text);

        return InkWell(
          onTap: onClick,
          child: Container(
            width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
