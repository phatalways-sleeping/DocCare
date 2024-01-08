// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/screens/users/prescription/controller/prescription_bloc.dart';
import 'package:views/src/screens/users/prescription/widgets/dc_async_items.dart';

class DCBlankScreen extends StatefulWidget {
  const DCBlankScreen({
    super.key,
  });

  @override
  _DCBlankScreenState createState() => _DCBlankScreenState();
}

class _DCBlankScreenState extends State<DCBlankScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DCCustomerHeaderBar(
        title: 'DocCare',
      ),
      drawer: DCCustomerDrawer(),
      bottomNavigationBar: DCCustomerNavigationBar(
        selectedIndex: 1,
      ),
      extendBody: true,
      body: SizedBox(),
    );
  }
}
