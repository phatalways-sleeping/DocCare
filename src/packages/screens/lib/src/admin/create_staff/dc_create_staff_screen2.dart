// ignore_for_file: public_member_api_docs

import 'package:administrator/administrator.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screens/src/admin/controller/create_staff_bloc.dart';
import 'package:utility/utility.dart';

class DCCreateStaffScreen2 extends StatefulWidget {
  const DCCreateStaffScreen2({super.key});

  @override
  State<DCCreateStaffScreen2> createState() => _DCCreateStaffScreen2State();
}

class _DCCreateStaffScreen2State extends State<DCCreateStaffScreen2> {
  String selectedRole = 'Doctor';
  List<Widget> _widgetList = [];
  @override
  Widget build(BuildContext context) {
    // TODO(phucchuhoang): change appBar to custom app bar
    return Scaffold(
      appBar: DCAdminHeaderBar(
        headerBarTitle: ('Create staff'),
        allowNavigationBack: true,
      ),
      body: BlocProvider(
        create: (_) => CreateStaffBloc(NotificationManager.instance,
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
                        WorkingShiftWidget(
                          onItemSelected: (context, controller) => context
                              .read<CreateStaffBloc>()
                              .add(FullNameInputEvent(controller as String)),
                        ),
                        // DCOutlinedWithHeadingTextFormField(
                        //   heading: const Text('Full Name'),
                        //   headingColor: context.colorScheme.onSurface,
                        //   borderColor: context.colorScheme.onBackground,
                        //   color: context.colorScheme.onBackground,
                        //   borderRadius: 16,
                        //   keyboardType: TextInputType.name,
                        //   onChanged: (context, controller) => context
                        //       .read<CreateStaffBloc>()
                        //       .add(FullNameInputEvent(controller.text)),
                        // ),
                        // const SizedBox(height: 16),
                        // Text('Specialization',
                        //     textAlign: TextAlign.justify,
                        //     style: context.textTheme.h6RegularPoppins.copyWith(
                        //       color: context.colorScheme.onBackground
                        //           .withOpacity(0.8),
                        //     )),
                        // const SizedBox(height: 16),
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
