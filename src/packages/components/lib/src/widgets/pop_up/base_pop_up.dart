import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class BasePopup extends StatelessWidget {
  const BasePopup({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.buttonColor,
    required this.popupIcon,
    this.textColor,
    this.popupIconWidth,
    this.popupIconHeight,
    super.key,
  });

  final String title;
  final String message;
  final String buttonText;
  final Color buttonColor;
  final Widget popupIcon;
  final Color? textColor;
  final double? popupIconWidth;
  final double? popupIconHeight;

  @override
  Widget build(BuildContext context) {
    //Center everything in the middle column using Alert Dialog
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      titleTextStyle: TextStyle(
        fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
        fontSize: 20,
        color: textColor ?? context.colorScheme.primary,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: popupIconWidth ?? 100,
            height: popupIconHeight ?? 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: buttonColor,
            ),
            child: Transform.scale(
              scale: 0.75,
              child: popupIcon,
            ),
          ),
          Text(
            message,
            style: TextStyle(
              fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
              color: textColor ?? context.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
              color: textColor ?? context.colorScheme.primary,
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
