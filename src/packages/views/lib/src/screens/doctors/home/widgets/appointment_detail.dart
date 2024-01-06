// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:views/src/screens/doctors/home/controller/doctor_home_bloc.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  const AppointmentDetailsWidget({
    required this.customerName,
    required this.day,
    required this.time,
    required this.isNull,
    Key? key,
  }) : super(key: key);
  final String customerName;
  final String day;
  final String time;
  final bool isNull;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.secondary.withOpacity(0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<DoctorHomeBloc, DoctorHomeState>(
                builder: (context, state) {
                  return DCFilledButton(
                    backgroundColor: state.upcomingAppointmentIndex == -1
                        ? context.colorScheme.quinary
                        : context.colorScheme.error,
                    fixedSize: Size(
                      context.width * 0.3,
                      25,
                    ),
                    onPressed: (acontext) async {
                      if (state.upcomingAppointmentIndex == -1) {
                        return;
                      }
                      await showDialog<void>(
                        context: context,
                        builder: (acontext) => DCPopupDoctorCancel(
                          boldMessage: 'Are you sure?',
                          message: 'Your patients need you!',
                          cancelButtonText: 'Cancel',
                          confirmButtonText: 'Confirm',
                          onCancelButtonClicked: (acontext) {
                            // Close the dialog
                            Navigator.of(context).pop();
                          },
                          onConfirmButtonClicked: (acontext) {
                            //remove the appointment
                            Navigator.of(context).pop();

                            BlocProvider.of<DoctorHomeBloc>(context).add(
                              DoctorHomeOpenCancelAppointmentViewEvent(
                                appointment: state.appointments[
                                    state.upcomingAppointmentIndex],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 14,
                        color: context.colorScheme.onError,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.h2BoldPoppins.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.left,
                child: Text(
                  customerName,
                ),
              ),
            ],
          ),
          SizedBox(height: context.height * 0.02),
          if (isNull == false)
            Row(
              children: [
                AppointmentInfo(icon: true, text: day),
                const SizedBox(width: 20),
                AppointmentInfo(icon: false, text: time),
              ],
            )
          else
            const SizedBox(
              height: 20,
            ),
        ],
      ),
    );
  }
}

class AppointmentInfo extends StatelessWidget {
  final bool icon;
  final String text;

  const AppointmentInfo({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.secondary.withOpacity(0.5),
        border: Border.all(
          color: context.colorScheme.background, // Change the color as needed
        ),
      ),
      child: Row(
        children: [
          SvgPicture.string(
            icon == true ? DCSVGIcons.day : DCSVGIcons.time,
            height: 35,
            width: 35,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: context.textTheme.bodyRegularPoppins.copyWith(
              fontSize: 14,
              color: context.colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
