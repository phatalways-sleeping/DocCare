import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCButton extends StatelessWidget
{
  DCButton({
    required this.onTap,
    this.borderRadius,
    this.buttonColor,
    this.textColor,
    required this.text,
    this.borderColor,
    this.textSize,
    this.width,
    this.height,
    Key? key,

  }) : super(key: key);

  VoidCallback onTap;
  Color? buttonColor;
  double? borderRadius;
  Color? textColor;
  String text;
  Color? borderColor;
  double ? textSize;
  double ? width;
  double ? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300,
      height: height ?? 100,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        
        color: buttonColor ?? Colors.greenAccent,
        border: Border.all( color: borderColor ?? Colors.black), // border Color
        borderRadius: BorderRadius.circular(borderRadius?? 80)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: textSize ?? 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: context.textTheme.h6BoldPoppins.fontFamily
                  ),
                )
                ),
            ),

          ),
        ),
    );
  }
}