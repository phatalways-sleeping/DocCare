import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/booking/doctor_view/view/dc_doctor_card.dart';
import 'package:screens/src/booking/doctor_view/view/dc_search_bar.dart';

class DCDoctorViewScreen extends StatefulWidget {
  const DCDoctorViewScreen({super.key});

  @override
  State<DCDoctorViewScreen> createState() => _DCDoctorViewScreenState();
}

class _DCDoctorViewScreenState extends State<DCDoctorViewScreen> {
  final controller = ScrollController();
  bool showBottomNavBar = true;
  @override
  void initState() {
    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent - 100 &&
          !controller.position.outOfRange) {
        // hide bottom nav bar
        setState(() {
          showBottomNavBar = false;
        });
      }
      if (controller.offset <= controller.position.minScrollExtent &&
          !controller.position.outOfRange) {
        // show bottom nav bar
        setState(() {
          showBottomNavBar = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCCustomerHeaderBar(
        title: 'DocCare',
      ),
      body: SingleChildScrollView(
        controller: controller,
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              child: const DCSearchBar(),
            ),
            const SizedBox(
              height: 10,
            ),
            for (int i = 0; i < 10; i++)
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: context.height * 0.01,
                ),
                child: const DCDoctorCard(
                  name: 'Dr. John Doe',
                  speciality: 'Dentist',
                  rating: 4.5,
                  ratingCount: 100,
                  imgPath: 'assets/images/doctor.png',
                ),
              ),
          ],
        ),
      ),
      drawer: const DCCustomerDrawer(),
      extendBody: true,
      bottomNavigationBar: showBottomNavBar
          ? DCCustomerNavigationBar(
              onItemSelected: (context, index) {},
              selectedIndex: 2,
            )
          : null,
    );
  }
}
