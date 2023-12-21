import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCPopupAbsentRequest extends StatelessWidget {
  const DCPopupAbsentRequest({
    Key? key,
    required this.title,
    required this.doctorName,
    required this.messageAbsentDate,
    required this.messageReasons,
    required this.messageNotes,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.doctorNameTextSize,
    this.doctorNameTextColor,
    this.rejectButtonText,
    this.confirmButtonText,
    this.messageAbsentTextSize,
    this.messageAbsentTextColor,
    this.messageReasonTextSize,
    this.messageReasonTextColor,
    this.messageNotesTextSize,
    this.messageNotesTextColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.rejectButtonColor,
    this.confirmButtonColor,
    this.buttonsTextSize,
    this.rejectButtonTextColor,
    this.confirmButtonTextColor,
    this.onRejectButtonClicked,
    this.onConfirmButtonClicked,
  }) : super(key: key);

  final String title;
  final Color? titleTextColor;
  final double? titleTextSize;
  final TextAlign? titleAlignment;

  final String doctorName;
  final Color? doctorNameTextColor;
  final double? doctorNameTextSize;

  final String messageAbsentDate;
  final Color? messageAbsentTextColor;
  final double? messageAbsentTextSize;

  final String messageReasons;
  final Color? messageReasonTextColor;
  final double? messageReasonTextSize;

  final String messageNotes;
  final Color? messageNotesTextColor;
  final double? messageNotesTextSize;

  final String? rejectButtonText;
  final String? confirmButtonText;
  final Color? rejectButtonTextColor;
  final Color? confirmButtonTextColor;
  final Color? rejectButtonColor;
  final Color? confirmButtonColor;

  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final void Function(BuildContext context)? onRejectButtonClicked;
  final void Function(BuildContext context)? onConfirmButtonClicked;

  @override
  Widget build(BuildContext context) {
    return BasePopup(
      title: Text(title),
      titleTextColor: titleTextColor ?? context.colorScheme.tertiary,
      titleTextSize: titleTextSize ?? 24,
      titleAlignment: titleAlignment,
      message: [
        FractionallySizedBox(
          widthFactor: 1,
          child: DefaultTextStyle.merge(
            style: context.textTheme.h4RegularPoppins.copyWith(
              fontSize: doctorNameTextSize ?? 14,
              fontWeight: FontWeight.normal,
              color: doctorNameTextColor ?? context.colorScheme.onTertiary,
            ),
            textAlign: TextAlign.center,
            child: Text('$doctorName requests for an absence from work'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: doctorNameTextSize ?? 20,
                fontWeight: FontWeight.bold,
                color: doctorNameTextColor ?? context.colorScheme.onTertiary,
              ),
              textAlign: TextAlign.center,
              child: const Text('Details'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DefaultTextStyle.merge(
            style: context.textTheme.h4RegularPoppins.copyWith(
              fontSize: messageAbsentTextSize ?? 14,
              fontWeight: FontWeight.normal,
              color: messageAbsentTextColor ?? context.colorScheme.onTertiary,
            ),
            textAlign: TextAlign.left,
            child: Text('Absent on: $messageAbsentDate'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DefaultTextStyle.merge(
            style: context.textTheme.h4RegularPoppins.copyWith(
              fontSize: messageReasonTextSize ?? 14,
              fontWeight: FontWeight.normal,
              color: messageReasonTextColor ?? context.colorScheme.onTertiary,
            ),
            textAlign: TextAlign.center,
            child: Text('Reasons: $messageReasons'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DefaultTextStyle.merge(
            style: context.textTheme.h4RegularPoppins.copyWith(
              fontSize: messageNotesTextSize ?? 14,
              fontWeight: FontWeight.normal,
              color: messageNotesTextColor ?? context.colorScheme.onTertiary,
            ),
            textAlign: TextAlign.left,
            child: Text(messageNotes),
          ),
        ),
      ],
      buttonsText: [
        rejectButtonText ?? 'Reject',
        confirmButtonText ?? 'Confirm',
      ],
      buttonsColor: [
        rejectButtonColor ?? context.colorScheme.error,
        confirmButtonColor ?? context.colorScheme.primary,
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 14,
      buttonsTextColors: [
        rejectButtonTextColor ?? context.colorScheme.onBackground,
        confirmButtonTextColor ?? context.colorScheme.onBackground,
      ],
      onConfirmButtonClicked: onConfirmButtonClicked,
      onCancelButtonClicked: onRejectButtonClicked,
      hasPadding: false,
    );
  }
}
