// ignore_for_file: public_member_api_docs

import 'package:administrator/administrator.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/remove_controller/remove_staff_bloc.dart';
import 'package:utility/utility.dart';

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
          SupabaseAdminControlStaffApiService.instance,
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
      onLeadingIconPressed: () {
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
        if (state is RemoveStaffInitial) {
          return BodyScreen(state: state);
        }
        return const Text('Delete role successful');
      },
    );
  }
}

class BodyScreen extends StatelessWidget {
  final RemoveStaffState state;
  BodyScreen({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        // child: BlocBuilder<CreateStaffBloc, CreateStaffState>(
        //   builder: (context, state) {
        child: Column(
          children: [
            const Text(
              'Delete Account',
              textScaler: TextScaler.linear(2.0),
            ),
            const SizedBox(height: 16),
            DCAdminToggleButton(
              elements: ['Doctor', 'Receptionist'],
              selectedElements: [true, false].toList(),
              title: 'Role',
              onChanged: (context, controller) => {
                context
                    .read<RemoveStaffBloc>()
                    .add(RoleInputEvent(controller.text)),
              },
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
            const SizedBox(height: 16),
            InkWell(
              child: Center(
                child: DCButton(
                  text: 'Submit',
                  onPressed: (context) => context.read<RemoveStaffBloc>().add(
                        const RemoveStaffButtonPressedEvent(),
                      ),
                ),
              ),
            ),
          ],
        )
        // ),
        );
  }
}
