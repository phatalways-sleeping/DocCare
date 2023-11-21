import 'package:components/components.dart';
import 'package:components/src/widgets/pop_up/base_pop_up.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCPopupCancellation extends StatelessWidget {
  const DCPopupCancellation({
    Key? key,
    required this.title,
    required this.newAppointmentMessage,
    required this.symtompsMessage,
    required this.noteMessage,
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
    this.buttonsTextSize,
    this.buttonsTextColors,
    this.onConfirmButtonClicked,
  }) : super(key: key);

  final String title;
  final Color? titleTextColor;
  final double? titleTextSize;
  final TextAlign? titleAlignment;

  final String newAppointmentMessage;
  final String symtompsMessage;
  final String noteMessage;

  final Color? messageTextColor;
  final double? messageTextSize;

  final Color? boldMessageTextColor;
  final double? boldMessageTextSize;

  final String? confirmButtonText;
  final Color? confirmButtonColor;
  final double? buttonsWidth;
  final double? buttonsHeight;
  final double? buttonsTextSize;
  final Color? buttonsTextColors;

  final void Function(BuildContext context)? onConfirmButtonClicked;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog

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
        confirmButtonText ?? 'Agree',
      ],
      buttonsColor: [
        confirmButtonColor ?? const Color.fromRGBO(14, 190, 127, 1),
      ],
      buttonsWidth: buttonsWidth,
      buttonsHeight: buttonsHeight,
      buttonsTextSize: buttonsTextSize ?? 16,
      buttonsTextColors: buttonsTextColors ?? context.colorScheme.background,
      onConfirmButtonClicked: (context) =>
          onConfirmButtonClicked ?? Navigator.of(context).pop(),
    );
  }
}
