// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/widgets/dc_async_items.dart';

class DCMedicineScreen extends StatefulWidget {
  const DCMedicineScreen({
    super.key,
  });

  @override
  State<DCMedicineScreen> createState() => _DCMedicineScreenState();
}

class _DCMedicineScreenState extends State<DCMedicineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCCustomerHeaderBar(
        title: 'DocCare',
        allowNavigateBack: true,
        onLeadingIconPressed: (context) => context.read<PrescriptionBloc>().add(
              const PrescriptionResetEvent(),
            ),
      ),
      drawer: const DCCustomerDrawer(),
      bottomNavigationBar: DCCustomerNavigationBar(
        onItemSelected: (BuildContext context, int index) {},
        selectedIndex: 1,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTextStyle.merge(
              style: context.textTheme.h2BoldPoppins.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.left,
              child: const Text('Your medicines'),
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.left,
              child: const Text('Next medicines'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PrescriptionBloc, PrescriptionState>(
              buildWhen: (previous, current) {
                if (previous.runtimeType != current.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return DCAsyncItems(
                  future: context.read<PrescriptionBloc>().getLatestMedicines(),
                  isDone: false,
                  medicine: true,
                );
              },
            ),
            SizedBox(
              height: context.height * 0.03,
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.left,
              child: const Text('Past medicines'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PrescriptionBloc, PrescriptionState>(
              buildWhen: (previous, current) {
                if (previous.runtimeType != current.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return DCAsyncItems(
                  future: context.read<PrescriptionBloc>().getPastMedicines(),
                  isDone: true,
                  medicine: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
