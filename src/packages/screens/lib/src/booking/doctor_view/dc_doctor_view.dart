import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/booking/doctor_view/dc_search_bar.dart';

class DCDoctorViewScreen extends StatefulWidget {
  const DCDoctorViewScreen({super.key});

  @override
  State<DCDoctorViewScreen> createState() => _DCDoctorViewScreenState();
}

class _DCDoctorViewScreenState extends State<DCDoctorViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCCustomerHeaderBar(
        title: 'DocCare',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
        ).copyWith(
          top: context.height * 0.025,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Category: ',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Dentist',
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                IconButton.filled(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  splashColor: Colors.white,
                  highlightColor: Colors.white,
                  icon: SvgPicture.string(
                    DCSVGIcons.filter,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const DCSearchBar(),
          ],
        ),
      ),
      drawer: const DCCustomerDrawer(),
    );
  }
}
