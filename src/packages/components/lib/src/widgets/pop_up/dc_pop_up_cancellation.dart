import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// [DCPopupCancellation] is a popup that can be used to show a message to the user
/// with a title and a list of message.
/// This is used when one wants to cancel an appointment.
class DCPopupCancellation extends StatelessWidget {
  /// Constructor for [DCPopupCancellation]
  const DCPopupCancellation({
    required this.title,
    required this.newAppointmentMessage,
    required this.symtompsMessage,
    required this.noteMessage,
    this.showCancelButton = false,
    super.key,
    this.titleTextSize,
    this.titleAlignment,
    this.titleTextColor,
    this.confirmButtonColor,
    this.messageTextSize,
    this.messageTextColor,
    this.boldMessageTextSize,
    this.boldMessageTextColor,
    this.buttonsWidth,
    this.buttonsHeight,
    this.confirmButtonText,
    this.cancelButtonText,
    this.cancelButtonColor,
    this.buttonsTextSize,
    this.buttonsTextColors,
    this.onConfirmButtonClicked,
    this.onCancelButtonClicked,
  });

  /// The title of the popup
  final String title;

  /// The color of the title
  final Color? titleTextColor;

  /// The size of the title
  final double? titleTextSize;

  /// The alignment of the title
  final TextAlign? titleAlignment;

  /// The message of the popup for the new appointment
  final String newAppointmentMessage;

  /// The message of the popup for the symtomps
  final String symtompsMessage;

  /// The message of the popup for the note
  final String noteMessage;

  /// The color of the message
  final Color? messageTextColor;

  /// The size of the message
  final double? messageTextSize;

  /// The color of the bold message
  final Color? boldMessageTextColor;

  /// The size of the bold message
  final double? boldMessageTextSize;

  /// The text of the confirm button
  final String? confirmButtonText;

  /// The color of the confirm button
  final Color? confirmButtonColor;

  /// The text of the cancel button
  final String? cancelButtonText;

  /// The color of the cancel button
  final Color? cancelButtonColor;

  /// The width of the buttons
  final double? buttonsWidth;

  /// The height of the buttons
  final double? buttonsHeight;

  /// The size of the buttons text
  final double? buttonsTextSize;

  /// The color of the buttons text
  final Color? buttonsTextColors;

  /// Whether to show the cancel button or not
  final bool showCancelButton;

  /// The function to be called when the confirm button is clicked
  final void Function(BuildContext context)? onConfirmButtonClicked;

  /// The function to be called when the cancel button is clicked
  final void Function(BuildContext context)? onCancelButtonClicked;

  @override
  Widget build(BuildContext context) {
    return BasePopup(
      popupPadding: 20,
      title: Text(title),
      titleTextColor: titleTextColor ?? context.colorScheme.onBackground,
      titleTextSize: titleTextSize ?? 20,
      titleAlignment: titleAlignment ?? TextAlign.left,
      messageAlligment: CrossAxisAlignment.start,
      message: [
        DefaultTextStyle.merge(
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontSize: boldMessageTextSize ?? 20,
            fontWeight: FontWeight.bold,
            color: boldMessageTextColor ?? context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.left,
          child: const Text('New appointment'),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: messageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(newAppointmentMessage),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: boldMessageTextSize ?? 20,
            fontWeight: FontWeight.bold,
            color: boldMessageTextColor ?? context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.left,
          child: const Text('Symtomps'),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: messageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(symtompsMessage),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4BoldPoppins.copyWith(
            fontSize: boldMessageTextSize ?? 20,
            fontWeight: FontWeight.bold,
            color: boldMessageTextColor ?? context.colorScheme.onBackground,
          ),
          textAlign: TextAlign.left,
          child: const Text('Note'),
        ),
        DefaultTextStyle.merge(
          style: context.textTheme.h4RegularPoppins.copyWith(
            fontSize: messageTextSize ?? 14,
            fontWeight: FontWeight.normal,
            color: messageTextColor ?? context.colorScheme.tertiary,
          ),
          textAlign: TextAlign.left,
          child: Text(noteMessage),
        ),
      ],
      buttonsText: [
        if (showCancelButton) cancelButtonText ?? 'Cancel',
        confirmButtonText ?? 'Agree',
      ],
      buttonsColor: [
        if (showCancelButton) cancelButtonColor ?? context.colorScheme.error,
        confirmButtonColor ?? context.colorScheme.senary,
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.background,
      onConfirmButtonClicked: onConfirmButtonClicked,
      onCancelButtonClicked: onCancelButtonClicked,
    );
  }
}
