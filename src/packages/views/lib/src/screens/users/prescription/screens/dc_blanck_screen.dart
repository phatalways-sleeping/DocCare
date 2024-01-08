// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:flutter/material.dart';

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
