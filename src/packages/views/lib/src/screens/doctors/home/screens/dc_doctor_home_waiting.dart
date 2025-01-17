// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCDoctorHomeWaitingScreen extends StatefulWidget {
  const DCDoctorHomeWaitingScreen({
    super.key,
  });

  @override
  _DCDoctorHomeWaitingScreenState createState() =>
      _DCDoctorHomeWaitingScreenState();
}

String mapMonth(int month) {
  switch (month) {
    case 1:
      return 'Jan';
    case 2:
      return 'Feb';
    case 3:
      return 'Mar';
    case 4:
      return 'Apr';
    case 5:
      return 'May';
    case 6:
      return 'Jun';
    case 7:
      return 'July';
    case 8:
      return 'Aug';
    case 9:
      return 'Sep';
    case 10:
      return 'Oct';
    case 11:
      return 'Nov';
    default:
      return 'Dec';
  }
}

String mapPeriod(String period) {
  switch (period) {
    case '1':
      return '7:00 AM';
    case '2':
      return '8:00 AM';
    case '3':
      return '8:30 AM';
    case '4':
      return '9:00 AM';
    case '5':
      return '9:30 AM';
    case '6':
      return '10:00 AM';
    case '7':
      return '10:30 AM';
    case '8':
      return '11:00 AM';
    case '9':
      return '11:30 AM';
    case '10':
      return '12:00 PM';
    case '11':
      return '12:30 PM';
    case '12':
      return '1:00 PM';
    case '13':
      return '1:30 PM';
    case '14':
      return '2:00 PM';
    case '15':
      return '2:30 PM';
    case '16':
      return '3:00 PM';
    case '17':
      return '3:30 PM';
    case '18':
      return '4:00 PM';
    case '19':
      return '4:30 PM';

    default:
      return '5:00 PM';
  }
}

class _DCDoctorHomeWaitingScreenState extends State<DCDoctorHomeWaitingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DCDoctorHeaderBar(
        title: 'DocCare',
      ),
      drawer: const DCDoctorDrawer(),
      // bottomNavigationBar: const DCDoctorNavigationBar(),
      extendBody: true,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: context.height * 0.03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: context.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 20),
            DefaultTextStyle.merge(
                style: context.textTheme.h2BoldPoppins.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.left,
                child: const Text(
                  'Upcoming Appointment',
                )),
            const SizedBox(height: 8),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: context.colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SvgPicture.string(
                  DCSVGIcons.bookingCalendar,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '${mapMonth(DateTime.now().month)} ${DateTime.now().year}',
                  style: context.textTheme.bodyRegularPoppins.copyWith(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: context.colorScheme.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
