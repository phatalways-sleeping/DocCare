// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:views/src/screens/users/booking/booking_view/controller/booking_bloc.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_async_view.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_calendart.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_loading_view.dart';
import 'package:views/src/screens/users/booking/booking_view/dc_speciality_button.dart';
import 'package:views/src/screens/users/booking/booking_view/show_appointment_confirm.dart';
import 'package:views/src/screens/users/booking/booking_view/show_result_dialog.dart';
import 'package:views/src/screens/users/booking/doctor_view/controller/doctor_view_bloc.dart';
import 'package:views/src/screens/users/booking/doctor_view/view/dc_doctor_card.dart';

class DCBookingWithDoctorScreen extends StatefulWidget {
  const DCBookingWithDoctorScreen({
    super.key,
    this.inCustomerView = true,
  });

  /// If [inCustomerView] is true, the screen will be shown in the customer view
  /// else it will be shown in the receptionist view
  final bool inCustomerView;

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
      resizeToAvoidBottomInset: true,
      appBar: context.watch<BookingBloc>().state is BookingSuccess
          ? null
          : context.watch<BookingBloc>().state.doctorData.keys.isEmpty
              ? DCCustomerHeaderBar(
                  title: 'Booking',
                  allowNavigateBack:
                      context.watch<BookingBloc>().state.dateSelected != null,
                  onLeadingIconPressed: (context) =>
                      context.read<BookingBloc>().add(
                            const BookingBackToInitialEvent(),
                          ),
                )
              : DCCustomerHeaderBar(
                  title: 'Booking',
                  allowNavigateBack: true,
                  onLeadingIconPressed: (context) =>
                      context.read<DoctorViewBloc>().add(
                            const DoctorViewInitialEvent(),
                          ),
                ),
      drawer: widget.inCustomerView ? const DCCustomerDrawer() : null,
      bottomNavigationBar:
          (context.watch<BookingBloc>().state.doctorData.isNotEmpty ||
                  context.watch<BookingBloc>().state.dateSelected != null)
              ? null
              : (widget.inCustomerView
                  ? const DCCustomerNavigationBar(
                      selectedIndex: 3,
                    )
                  : const DCReceptionistNavigationBar(
                      selectedIndex: 3,
                    )),
      extendBody: true,
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) async {
          if (state is BookingFailure) {
            await showFailedDialog(context: context).then(
              (value) =>
                  context.read<BookingBloc>().add(const BookingResetEvent()),
            );
          } else if (state is BookingSuccess) {
            if (state.doctorData.isNotEmpty) {
              await showSuccessfulWithDoctorDialog(
                context: context,
                doctorData: state.doctorData,
                dateSelected: state.dateSelected!,
                timeSelected: state.timeSelected!,
              ).then(
                (value) => context.read<DoctorViewBloc>().add(
                      const DoctorViewInitialEvent(),
                    ),
              );
            } else {
              await showSuccessfulDialog(
                context: context,
                dateSelected: state.dateSelected!,
                timeSelected: state.timeSelected!,
              ).then(
                (value) => context.read<BookingBloc>().add(
                      const BookingBackToInitialEvent(),
                    ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is BookingSuccess) {
            return const SizedBox.shrink();
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
                          imgPath: (state['imageUrl'] as String?) ?? '',
                          name: (state['name'] as String?) ?? '',
                          speciality: (state['speciality'] as String?) ?? '',
                          rating: (state['rating'] as num).toDouble(),
                          ratingCount: state['ratingCount'] as int,
                          onPressed: null,
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
                    DCCalendar(
                      workingShiftFuture:
                          context.read<BookingBloc>().getDoctorWorkingShift(
                                doctorid: (context
                                            .read<BookingBloc>()
                                            .state
                                            .doctorData['id'] !=
                                        null
                                    ? context
                                        .read<BookingBloc>()
                                        .state
                                        .doctorData['id'] as String
                                    : ''),
                              ),
                    ),
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
                        future: context
                            .read<BookingBloc>()
                            .getDoctorSpecialization(),
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
                            null &&
                        (context
                                .watch<BookingBloc>()
                                .state
                                .doctorData
                                .isNotEmpty ||
                            context.watch<BookingBloc>().state.speciality !=
                                null)) ...[
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
                        future: (context
                                .read<BookingBloc>()
                                .state
                                .doctorData
                                .keys
                                .isNotEmpty
                            ? context
                                .read<DoctorViewBloc>()
                                .getAvailableAppointmentTimes(
                                  context
                                      .read<BookingBloc>()
                                      .state
                                      .doctorData['id'] as String,
                                  context
                                      .watch<BookingBloc>()
                                      .state
                                      .dateSelected!,
                                )
                            : context
                                .read<BookingBloc>()
                                .getAvailablePeriodWithSpecialization(
                                  context.read<BookingBloc>().state.speciality!,
                                  context
                                      .watch<BookingBloc>()
                                      .state
                                      .dateSelected!,
                                )),
                        type: DCAsyncViewType.availableTime,
                      ),
                      SizedBox(
                        height: context.height * 0.02,
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
                            context.width * 0.94,
                            50,
                          ),
                          backgroundColor: context.colorScheme.secondary,
                          child: Text(
                            'Continue',
                            style:
                                context.textTheme.bodyRegularPoppins.copyWith(
                              fontSize: 18,
                              color: context.colorScheme.onSecondary,
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
