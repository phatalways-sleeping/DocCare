// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCButton extends StatelessWidget {
  DCButton({
    required this.text,
    required this.onPressed,
    Key? key,
    this.textStyle,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
    this.textSize,
    this.borderWidth,
    this.pressedOpacity,
    this.hoveredOpacity,
    this.imageLeft,
    this.imageRight,
    this.heightFactor,
    this.widthFactor,
    this.imageSize,
    this.gapBetweenElements,
  })  : assert(
          textSize == null || (textSize > 5 && textSize < 100),
          'If textSize is provided, it should be between 5 and 100',
        ),
        assert(
          heightFactor == null || (heightFactor >= 0 && heightFactor <= 0.9),
          'If heightFactor is provided, it should be between 0 and 0.95',
        ),
        assert(
          widthFactor == null || (widthFactor >= 0 && widthFactor <= 0.9),
          'If widthFactor is provided, it should be between 0 and 0.95',
        ),
        assert(
          imageSize == null || (imageSize > 5 && imageSize < 100),
          'If imageSize is provided, it should be between 5 and 100',
        ),
        assert(
          gapBetweenElements == null ||
              (gapBetweenElements > 5 && gapBetweenElements < 100),
          'If gapBetweenElements is provided, it should be between 5 and 100',
        ),
        super(key: key);
  final void Function(BuildContext context) onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final String text;
  final double? borderRadius;
  final double? textSize;
  final double? borderWidth;
  final double? pressedOpacity;
  final double? hoveredOpacity;
  final double? heightFactor;
  final double? widthFactor;
  final ImageProvider? imageLeft;
  final ImageProvider? imageRight;
  final double? imageSize;
  final double? gapBetweenElements;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final calculatedButtonWidth = widthFactor != null
        ? screenWidth *
            widthFactor! // Calculate button width based on widthFactor
        : screenWidth * 0.3; // Default to 30% of screen width

    final calculatedButtonHeight = heightFactor != null
        ? screenHeight *
            heightFactor! // Calculate button height based on heightFactor
        : screenHeight * 0.06; // Default to 6% of screen height

    const colorScheme = DocCareLightColorScheme();
    final textWidget = Text(
      text,
      style: textStyle ??
          context.textTheme.h6RegularPoppins.copyWith(
            color: textColor ?? colorScheme.onSecondary,
            fontSize: textSize,
          ),
      //maxLines: ButtonConfig.maxLines,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 80.0),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(
              Size(calculatedButtonWidth, calculatedButtonHeight)),
          side: MaterialStateProperty.resolveWith((states) {
            var width = borderWidth ?? 0.0;
            final borderColor = this.borderColor ?? colorScheme.onBackground;
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(
                color: colorScheme.tertiary,
                width: width,
              );
            } else if (states.contains(MaterialState.pressed)) {
              return BorderSide(
                color: borderColor.withOpacity(pressedOpacity ?? 0.5),
                width: width,
              );
            } else if (states.contains(MaterialState.hovered)) {
              return BorderSide(
                color: borderColor.withOpacity(hoveredOpacity ?? 0.8),
                width: width,
              );
            }
            return BorderSide(
              color: borderColor,
              width: width,
            );
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            final backgroundColor = this.backgroundColor ?? colorScheme.primary;
            if (states.contains(MaterialState.disabled)) {
              return colorScheme.tertiary;
            } else if (states.contains(MaterialState.pressed)) {
              return backgroundColor.withOpacity(pressedOpacity ?? 0.5);
            } else if (states.contains(MaterialState.hovered)) {
              return backgroundColor.withOpacity(hoveredOpacity ?? 0.8);
            }
            return backgroundColor;
          }),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 80),
            ),
          ),
        ),
        onPressed: () => onPressed(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 8.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (imageLeft != null)
                Image(
                  image: imageLeft!,
                  width: imageSize ?? 14,
                  height: imageSize ?? 14,
                  fit: BoxFit.scaleDown,
                ),
              SizedBox(
                width: imageLeft != null ? gapBetweenElements ?? 10 : 0,
              ),
              SizedBox(
                width: imageRight != null ? gapBetweenElements ?? 10 : 0,
              ),
              if (imageRight != null)
                Image(
                  image: imageRight!,
                  width: imageSize ?? 14,
                  height: imageSize ?? 14,
                  fit: BoxFit.scaleDown,
                ),
              textWidget,
            ],
          ),
        ),
      ),
    );
  }
}
