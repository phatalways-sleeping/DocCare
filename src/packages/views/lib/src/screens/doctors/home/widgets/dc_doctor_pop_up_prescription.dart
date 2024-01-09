import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [DCPopupDoctorPrescription] is a popup that can be used to show a message to the user
/// with a title and a list of message.
/// This is used when one wants to review their intake.
class DCPopupDoctorPrescription extends StatefulWidget {
  /// Constructor for [DCPopupDoctorPrescription]
  const DCPopupDoctorPrescription({
    required this.title,
    required this.diagnosisMessage,
    required this.medicinesMessage,
    required this.noteMessage,
    required this.customerName,
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
    this.onConfirmButtonClicked,
    this.buttonsTextSize,
    this.showReview = 5,
    this.totalRating = 0,
  });

  ///The name of the doctor
  final String customerName;

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



  /// The width of the buttons
  final double? buttonsWidth;

  /// The height of the buttons
  final double? buttonsHeight;

  /// The size of the buttons text
  final double? buttonsTextSize;

  /// The color of the confirm text
  final Color? confirmButtonTextColor;

  // Whether to show the review button or not
  final int? showReview;

  /// The function to be called when the confirm button is clicked
  final void Function(BuildContext context)? onConfirmButtonClicked;

  // The total rating of the intake
  final int totalRating;

  @override
  State<StatefulWidget> createState() => _DCPopupDoctorPrescriptionState();
}

class _DCPopupDoctorPrescriptionState extends State<DCPopupDoctorPrescription> {
  int currentRating = 0;

  List<SvgPicture> ratings = List<SvgPicture>.generate(
    5,
    (index) => SvgPicture.string(
      DCSVGIcons.yellowStar,
      fit: BoxFit.cover,
    ),
  );

  @override
  Widget build(BuildContext context) {
    currentRating =
        (currentRating > 0) ? currentRating : widget.showReview ?? 0;
    ratings = List<SvgPicture>.generate(
      5,
      (index) => ((widget.showReview == null && currentRating == 0) ||
              index >= currentRating)
          ? SvgPicture.string(
              DCSVGIcons.greyStar,
              fit: BoxFit.cover,
            )
          : SvgPicture.string(
              DCSVGIcons.yellowStar,
              fit: BoxFit.cover,
            ),
    );

    return BasePopup(
      popupPadding: 20,
      title: Column(
        children: [
          Text(widget.title),
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
                child: Text('For ${widget.customerName}'),
              ),
            ],
          ),
        ],
      ),
      titleTextColor: widget.titleTextColor ?? context.colorScheme.onBackground,
      titleTextSize: widget.titleTextSize ?? 20,
      titleAlignment: widget.titleAlignment ?? TextAlign.center,
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
                fontSize: widget.diagnosisMessageTextSize ?? 20,
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
            fontSize: widget.diagnosisMessageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color:
                widget.confirmButtonTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(widget.diagnosisMessage),
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
                fontSize: widget.medicinesMessageTextSize ?? 20,
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
            fontSize: widget.medicinesMessageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: widget.medicinesMessageTextColor ??
                context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(widget.medicinesMessage),
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
                fontSize: widget.noteMessageTextSize ?? 20,
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
            fontSize: widget.noteMessageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: widget.noteMessageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(widget.noteMessage),
        ),
        
      ],
      buttonsText: (widget.showReview == null)
          ? [
             // widget.reviewButtonText ?? 'Review',
              widget.confirmButtonText ?? 'Done',
            ]
          : [widget.confirmButtonText ?? 'Done'],
      buttonsColor: (widget.showReview == null)
          ? [
              //widget.reviewButtonColor ?? context.colorScheme.senary,
              widget.confirmButtonColor ?? context.colorScheme.senary,
            ]
          : [
              widget.confirmButtonColor ?? context.colorScheme.senary,
            ],
      buttonsWidth: widget.buttonsWidth,
      buttonsHeight: widget.buttonsHeight,
      buttonsTextSize: widget.buttonsTextSize ?? 16,
      buttonsTextColors: (widget.showReview == null)
          ? [
              //widget.reviewButtonTextColor ?? context.colorScheme.onBackground,
              widget.confirmButtonTextColor ?? context.colorScheme.onBackground,
            ]
          : [
              widget.confirmButtonTextColor ?? context.colorScheme.onBackground,
            ],
      onConfirmButtonClicked: widget.onConfirmButtonClicked,
      // onCancelButtonClicked: widget.onReviewButtonClicked ??
      //     ((widget.showReview == null)
      //         ? (context) {
      //             Navigator.pop(context, currentRating);
      //           }
      //         : Navigator.pop),
    )
    ;
  }
}
