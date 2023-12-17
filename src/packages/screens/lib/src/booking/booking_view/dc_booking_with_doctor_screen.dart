// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/booking/booking_view/controller/booking_bloc.dart';
import 'package:screens/src/booking/booking_view/dc_async_view.dart';
import 'package:screens/src/booking/booking_view/dc_calendart.dart';
import 'package:screens/src/booking/doctor_view/controller/doctor_view_bloc.dart';
import 'package:screens/src/booking/doctor_view/view/dc_doctor_card.dart';

class DCBookingWithDoctorScreen extends StatefulWidget {
  const DCBookingWithDoctorScreen({super.key});

  @override
  State<DCBookingWithDoctorScreen> createState() =>
      _DCBookingWithDoctorScreenState();
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

class _DCBookingWithDoctorScreenState extends State<DCBookingWithDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DCCustomerHeaderBar(
        title: 'Booking',
        allowNavigateBack: true,
        onLeadingIconPressed: (context) => context.read<DoctorViewBloc>().add(
              const DoctorViewInitialEvent(),
            ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.03,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocSelector<BookingBloc, BookingState, Map<String, dynamic>>(
              selector: (state) => state.doctorData,
              builder: (context, state) {
                return DCDoctorCard(
                  imgPath: state['imgPath'] as String,
                  name: state['name'] as String,
                  speciality: state['speciality'] as String,
                  rating: state['rating'] as double,
                  ratingCount: state['ratingCount'] as int,
                  onPressed: (context) {},
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 10,
            ),
            const DCCalendar(),
            const SizedBox(
              height: 10,
            ),
            DCOutlinedTextFormField(
              borderRadius: 20,
              maxLines: 3,
              hintText: 'Type your symptoms here',
              keyboardType: TextInputType.text,
              color: const Color(0xFF677294),
              onChanged: (value, controller) {},
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Available Time',
              style: context.textTheme.bodyBoldPoppins.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DCAsyncView(
              future: Future.delayed(
                const Duration(seconds: 2),
                () => [
                  '10:00 AM',
                  '10:30 AM',
                  '11:00 AM',
                  '11:30 AM',
                ],
              ),
              type: DCAsyncViewType.availableTime,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Remind Me Before',
              style: context.textTheme.bodyBoldPoppins.copyWith(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DCAsyncView(
              future: Future.delayed(
                const Duration(seconds: 2),
                () => [
                  '10 Mins',
                  '20 Mins',
                  '30 Mins',
                  '40 Mins',
                ],
              ),
              type: DCAsyncViewType.reminder,
            ),
            SizedBox(
              height: context.height * 0.04,
            ),
            Align(
              child: DCFilledButton(
                onPressed: (context) {},
                fixedSize: Size(
                  context.width * 0.8,
                  50,
                ),
                child: Text(
                  'Continue',
                  style: context.textTheme.bodyBoldPoppins.copyWith(
                    fontSize: 18,
                    color: context.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
