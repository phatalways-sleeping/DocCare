import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCDoctorFilterScreen extends StatefulWidget {
  const DCDoctorFilterScreen({super.key});

  @override
  State<DCDoctorFilterScreen> createState() => _DCDoctorFilterScreenState();
}

class _DCDoctorFilterScreenState extends State<DCDoctorFilterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCCustomerHeaderBar(
        title: 'Filter',
        allowNavigateBack: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
        ).copyWith(
          top: context.height * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Speciality',
              style: context.textTheme.bodyBoldPoppins.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
