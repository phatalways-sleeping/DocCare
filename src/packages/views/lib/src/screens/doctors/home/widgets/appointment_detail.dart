import 'package:flutter/material.dart';
import 'package:extensions/extensions.dart';
import 'package:components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:components/src/widgets/pop_up/dc_pop_up_doctor_cancel.dart';
import 'package:views/src/screens/doctors/home/controller/doctor_home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  final String customerName;
  final String day;
  final String time;
  final bool isNull;

  const AppointmentDetailsWidget({
    Key? key,
    required this.customerName,
    required this.day,
    required this.time,
    required this.isNull,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
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
                  return DCButton(
                    text: 'Cancel',
                    textSize: 10,
                    backgroundColor: context.colorScheme.error,
                    heightFactor: 0.02,
                    widthFactor: 0.2,
                    onPressed: (context) {
                    
                      showDialog(
                        context: context,
                        builder: (acontext) => DCPopupDoctorCancel(
                            boldMessage: 'Are you sure?',
                            message: 'Your patients need you!',
                            onCancelButtonClicked: (context) {
                               // Close the dialog
                               Navigator.of(context).pop();
                            },
                            onConfirmButtonClicked: (context) {
                              // remove the appointment
                              context.read<DoctorHomeBloc>().add(
                                    DoctorHomeOpenCancelAppointmentViewEvent(
                                     
                                    ),
                                  );
                            }),
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Row(
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.h2BoldPoppins.copyWith(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.background,
                ),
                textAlign: TextAlign.left,
                child: Text(
                  customerName,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          isNull == false
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppointmentInfo(icon: true, text: day),
                    SizedBox(width: 20),
                    AppointmentInfo(icon: false, text: time),
                  ],
                )
              : SizedBox(
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
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.secondary,
        border: Border.all(
          color: context.colorScheme.onSecondary, // Change the color as needed
          width: 0.1, // Set the width of the border
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
          SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
