import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [DCPopupIntakeRating] is a popup that can be used to show a message to the user
/// with a title and a list of message.
/// This is used when one wants to review their intake.
class DCPopupIntakeRating extends StatelessWidget {
  /// Constructor for [DCPopupIntakeRating]
  const DCPopupIntakeRating({
    required this.title,
    required this.diagnosisMessage,
    required this.medicinesMessage,
    required this.noteMessage,
    required this.doctorName,
    super.key,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.diagnosisMessageTextSize,
    this.diagnosisMessageTextColor,
    this.medicinesMessageTextSize,
    this.medicinesMessageTextColor,
    this.noteMessageTextSize,
    this.noteMessageTextColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.confirmButtonText,
    this.confirmButtonTextColor,
    this.confirmButtonColor,
    this.reviewButtonText,
    this.reviewButtonColor,
    this.reviewButtonTextColor,
    this.onConfirmButtonClicked,
    this.onReviewButtonClicked,
    this.buttonsTextSize,
  });

  ///The name of the doctor
  final String doctorName;

  /// The title of the popup
  final String title;

  /// The color of the title
  final Color? titleTextColor;

  /// The size of the title
  final double? titleTextSize;

  /// The alignment of the title
  final TextAlign? titleAlignment;

  /// The message of the popup for the diagnosis
  final String diagnosisMessage;

  /// The message of the popup for the medicines
  final String medicinesMessage;

  /// The message of the popup for the note
  final String noteMessage;

  /// The color of the diagnosis message
  final Color? diagnosisMessageTextColor;

  /// The size of the diagnosis message
  final double? diagnosisMessageTextSize;

  /// The color of the medicines message
  final Color? medicinesMessageTextColor;

  /// The size of the medicines message
  final double? medicinesMessageTextSize;

  /// The color of the note message
  final Color? noteMessageTextColor;

  /// The size of the note message
  final double? noteMessageTextSize;

  /// The text of the confirm button
  final String? confirmButtonText;

  /// The color of the confirm button
  final Color? confirmButtonColor;

  /// The text of the review button
  final String? reviewButtonText;

  /// The color of the review button
  final Color? reviewButtonColor;

  /// The width of the buttons
  final double? buttonsWidth;

  /// The height of the buttons
  final double? buttonsHeight;

  /// The size of the buttons text
  final double? buttonsTextSize;

  /// The color of the confirm text
  final Color? confirmButtonTextColor;

  // The color of the review text
  final Color? reviewButtonTextColor;

  /// The function to be called when the confirm button is clicked
  final void Function(BuildContext context)? onConfirmButtonClicked;

  /// The function to be called when the cancel button is clicked
  final void Function(BuildContext context)? onReviewButtonClicked;

  @override
  Widget build(BuildContext context) {
    return BasePopup(
      popupPadding: 20,
      title: Column(
        children: [
          Text(title),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.h2RegularPoppins.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: context.colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
                child: Text('From Dr. $doctorName'),
              ),
            ],
          ),
        ],
      ),
      titleTextColor: titleTextColor ?? context.colorScheme.onBackground,
      titleTextSize: titleTextSize ?? 20,
      titleAlignment: titleAlignment ?? TextAlign.center,
      messageAlligment: CrossAxisAlignment.start,
      message: [
        Row(
          children: [
            FractionallySizedBox(
              child: SvgPicture.string(
                DCSVGIcons.diagnosis,
                fit: BoxFit.cover,
              ),
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: diagnosisMessageTextSize ?? 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
              textAlign: TextAlign.left,
              child: const Text('Diagnosis'),
            ),
          ],
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: diagnosisMessageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: diagnosisMessageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(diagnosisMessage),
        ),
        Row(
          children: [
            FractionallySizedBox(
              child: SvgPicture.string(
                DCSVGIcons.medicine,
                fit: BoxFit.cover,
              ),
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: medicinesMessageTextSize ?? 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
              textAlign: TextAlign.left,
              child: const Text('Medicines'),
            ),
          ],
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: medicinesMessageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: medicinesMessageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(medicinesMessage),
        ),
        Row(
          children: [
            FractionallySizedBox(
              child: SvgPicture.string(
                DCSVGIcons.note,
                fit: BoxFit.cover,
              ),
            ),
            DefaultTextStyle.merge(
              style: context.textTheme.h4BoldPoppins.copyWith(
                fontSize: noteMessageTextSize ?? 20,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onBackground,
              ),
              textAlign: TextAlign.left,
              child: const Text('Note'),
            ),
          ],
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: noteMessageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: noteMessageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(noteMessage),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontSize: noteMessageTextSize ?? 20,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.left,
          child: const Text('Review'),
        ),
      ],
      buttonsText: [
        reviewButtonText ?? 'Review',
        confirmButtonText ?? 'Done',
      ],
      buttonsColor: [
        reviewButtonColor ?? context.colorScheme.senary,
        confirmButtonColor ?? context.colorScheme.senary,
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: [
        reviewButtonTextColor ?? context.colorScheme.onBackground,
        confirmButtonTextColor ?? context.colorScheme.onBackground,
      ],
      onConfirmButtonClicked: onConfirmButtonClicked,
      onCancelButtonClicked: onReviewButtonClicked,
    );
  }
}
