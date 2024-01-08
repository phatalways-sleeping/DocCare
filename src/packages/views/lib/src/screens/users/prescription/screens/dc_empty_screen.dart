// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/widgets/dc_async_items.dart';

class DCEmptyScreen extends StatefulWidget {
  const DCEmptyScreen({
    super.key,
  });

  @override
  _DCEmptyScreenState createState() => _DCEmptyScreenState();
}

class _DCEmptyScreenState extends State<DCEmptyScreen> {
  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle.merge(
              style: context.textTheme.h2BoldPoppins.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.tertiary,
              ),
              textAlign: TextAlign.center,
              child: const Text('No records found'),
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/pic_2.png',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
