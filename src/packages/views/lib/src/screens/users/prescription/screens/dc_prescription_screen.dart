// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/widgets/dc_async_items.dart';

class DCPrescriptionScreen extends StatefulWidget {
  const DCPrescriptionScreen({
    super.key,
  });

  @override
  _DCPrescriptionScreenState createState() => _DCPrescriptionScreenState();
}

class _DCPrescriptionScreenState extends State<DCPrescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<PrescriptionBloc>().add(const PrescriptionEmptyEvent());

    return Scaffold(
      appBar: const DCCustomerHeaderBar(
        title: 'DocCare',
      ),
      drawer: const DCCustomerDrawer(),
      bottomNavigationBar: const DCCustomerNavigationBar(
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
              child: const Text('Your history'),
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
              child: const Text('Current Prescription'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PrescriptionBloc, PrescriptionState>(
              buildWhen: (previous, current) {
                if (current.runtimeType != previous.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return DCAsyncItems(
                  future:
                      context.read<PrescriptionBloc>().getLatestPrescription(),
                  isDone: false,
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
              child: const Text('Past Prescription'),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PrescriptionBloc, PrescriptionState>(
              buildWhen: (previous, current) {
                if (current.runtimeType != previous.runtimeType) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                return DCAsyncItems(
                  future:
                      context.read<PrescriptionBloc>().getPastPrescriptions(),
                  isDone: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
