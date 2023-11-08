import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCPopupFailed extends StatelessWidget {
  const DCPopupFailed({
    Key? key,
    required this.title,
    required this.message,
    required this.buttonText,
  }) : super(key: key);

  final String title;
  final String message;
  final String buttonText;

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
        color: context.colorScheme.primary,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Image.asset(
          //   'assets/images/red-alert.png',
          //   height: 100,
          //   width: 100,
          // ),
          Text(
            message,
            style: TextStyle(
              fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
              color: context.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
