// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screens/src/booking/booking_view/controller/booking_bloc.dart';
import 'package:screens/src/booking/booking_view/dc_async_view.dart';
import 'package:screens/src/booking/booking_view/dc_calendart.dart';
import 'package:screens/src/booking/booking_view/dc_loading_view.dart';
import 'package:screens/src/booking/booking_view/dc_speciality_button.dart';
import 'package:screens/src/booking/booking_view/show_appointment_confirm.dart';
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
      appBar: context.watch<BookingBloc>().state is BookingSuccess
          ? null
          : context.watch<BookingBloc>().state.doctorData.keys.isEmpty
              ? DCCustomerHeaderBar(
                  title: 'Booking',
                  allowNavigateBack:
                      context.watch<BookingBloc>().state.dateSelected != null,
                )
              : DCCustomerHeaderBar(
                  title: 'Booking',
                  allowNavigateBack: true,
                  onLeadingIconPressed: (context) =>
                      context.read<DoctorViewBloc>().add(
                            const DoctorViewInitialEvent(),
                          ),
                ),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state is BookingLoadingRequest) {}
        },
        builder: (context, state) {
          if (state is BookingSuccess) {
            final doctorData = state.doctorData;
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.03,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (doctorData.isNotEmpty)
                      DCDoctorCard(
                        imgPath: doctorData['imgPath'] as String,
                        name: doctorData['name'] as String,
                        speciality: doctorData['speciality'] as String,
                        rating: doctorData['rating'] as double,
                        ratingCount: doctorData['ratingCount'] as int,
                        onPressed: (context) {},
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Booking successful!',
                      style: context.textTheme.h3BoldPoppins.copyWith(
                        fontSize: 18,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your appointment has been booked successfully.',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your section shall start at ${state.timeSelected} on ${state.dateSelected!.year}/${state.dateSelected!.month}/${state.dateSelected!.day}.',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please come to the clinic on time. If you have any questions, please contact us at +84 123 456 789.',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: context.height * 0.04,
                    ),
                    DCFilledButton(
                      onPressed: (context) {
                        if (context
                            .read<BookingBloc>()
                            .state
                            .doctorData
                            .keys
                            .isEmpty) {
                          // Later, this will be changed to navigate to home screen
                          context.read<DoctorViewBloc>().add(
                                const DoctorViewInitialEvent(),
                              );
                        } else {
                          context.read<DoctorViewBloc>().add(
                                const DoctorViewInitialEvent(),
                              );
                        }
                      },
                      backgroundColor: context.colorScheme.primary,
                      fixedSize: Size(
                        context.width * 0.8,
                        50,
                      ),
                      child: Text(
                        'Come back to home',
                        style: context.textTheme.bodyBoldPoppins.copyWith(
                          fontSize: 18,
                          color: context.colorScheme.tertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.03,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocSelector<BookingBloc, BookingState,
                        Map<String, dynamic>>(
                      selector: (state) => state.doctorData,
                      builder: (context, state) {
                        if (state.keys.isEmpty) {
                          return const SizedBox.shrink();
                        }
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
                    if (context
                        .read<BookingBloc>()
                        .state
                        .doctorData
                        .keys
                        .isEmpty) ...[
                      DCSpecialityButton(
                        future: Future.delayed(
                          const Duration(seconds: 2),
                          () => [
                            'General Physician',
                            'Dentist',
                            'Cardiologist',
                            'Dermatologist',
                            'Gynecologist',
                            'Neurologist',
                            'Pediatrician',
                            'Psychiatrist',
                            'Urologist',
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                    DCOutlinedTextFormField(
                      borderRadius: 20,
                      maxLines: 3,
                      hintText: 'Type your symptoms here',
                      keyboardType: TextInputType.text,
                      color: const Color(0xFF677294),
                      onChanged: (context, controller) {
                        context.read<BookingBloc>().add(
                              BookingEnterSymptomEvent(
                                symptom: controller.text,
                              ),
                            );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (context.watch<BookingBloc>().state.dateSelected !=
                        null) ...[
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
                    ],
                    if (context.watch<BookingBloc>().state.timeSelected !=
                            null &&
                        (context
                                .watch<BookingBloc>()
                                .state
                                .doctorData
                                .isNotEmpty ||
                            context.watch<BookingBloc>().state.speciality !=
                                null)) ...[
                      Align(
                        child: DCFilledButton(
                          onPressed: (context) async {
                            await showAppointmentConfirm(
                              context: context,
                              doctorName: context
                                      .read<BookingBloc>()
                                      .state
                                      .doctorData
                                      .isNotEmpty
                                  ? context
                                      .read<BookingBloc>()
                                      .state
                                      .doctorData['name'] as String?
                                  : null,
                              time: context
                                  .read<BookingBloc>()
                                  .state
                                  .timeSelected!,
                              symptom:
                                  context.read<BookingBloc>().state.symptom,
                              date: context
                                  .read<BookingBloc>()
                                  .state
                                  .dateSelected!,
                              speciality:
                                  context.read<BookingBloc>().state.speciality,
                            ).then(
                              (value) => value
                                  ? context.read<BookingBloc>().add(
                                        const BookingConfirmEvent(),
                                      )
                                  : null,
                            );
                          },
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
                  ],
                ),
              ),
              if (state is BookingLoadingRequest) const DCLoadingView(),
            ],
          );
        },
      ),
    );
  }
}
