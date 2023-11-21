import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:components/src/theme/color_scheme/light_color_scheme.dart';
class DCButton extends StatelessWidget {
   DCButton({
    Key? key,
    required this.text,
    this.textStyle,
    required this.onPressed,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius,
    this.textSize,
    this.borderWidth,
    this.pressedOpacity,
    this.hoveredOpacity,
    this.heightFactor,
    this.widthFactor,
  }) : assert(
          textSize == null || (textSize! > 0 && textSize! < 100),
          'If textSize is provided, it should be between 0 and 100',
        ),
        
        super(key: key);
  final void Function(BuildContext context) onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final String text;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final double? textSize;
  final double? borderWidth;
  final double? pressedOpacity;
  final double? hoveredOpacity;
  final double? heightFactor; 
  final double? widthFactor;

  @override
  Widget build(BuildContext context) {
     final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double calculatedButtonWidth = widthFactor != null
        ? screenWidth * widthFactor! // Calculate button width based on widthFactor
        : screenWidth * 0.3; // Default to 50% of screen width

    final double calculatedButtonHeight = heightFactor != null
        ? screenHeight * heightFactor! // Calculate button height based on heightFactor
        : screenHeight * 0.06; // Default to 10% of screen height
    final DocCareLightColorScheme colorScheme = DocCareLightColorScheme();
    final textWidget = Text(
      text,
      style: textStyle ??
          context.textTheme.h6RegularPoppins.copyWith(
            color: textColor ?? colorScheme.onSecondary ,
            fontSize: this.textSize ?? 14,
          ),
      //maxLines: ButtonConfig.maxLines,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 80.0),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size(calculatedButtonWidth, calculatedButtonHeight)),
          side: MaterialStateProperty.resolveWith((states) {
            double width = borderWidth ?? 0.0;
            final borderColor =
                this.borderColor ?? colorScheme.onBackground;
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(
                color: colorScheme.tertiary,
                width: width,
              );
            } else if (states.contains(MaterialState.pressed)) {
              return BorderSide(
                color: borderColor.withOpacity(this.pressedOpacity ?? 0.5),
                width: width,
              );
            } else if (states.contains(MaterialState.hovered)) {
              return BorderSide(
                color: borderColor.withOpacity(this.hoveredOpacity ?? 0.8),
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
            } else if (states.contains(MaterialState.pressed) ) {
              return backgroundColor.withOpacity(this.pressedOpacity ?? 0.5);
            } else if (states.contains(MaterialState.hovered)) {
              return backgroundColor.withOpacity(this.hoveredOpacity ?? 0.8);
            }
            return backgroundColor;
          }),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(this.borderRadius ?? 80),
            ),
          ),
        ),
        onPressed: () => onPressed(context),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[             
              // if (fillParentWidth)
              //   Expanded(
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       mainAxisSize: MainAxisSize.min,
              //       // crossAxisAlignment: CrossAxisAlignment.stretch,
              //       children: <Widget>[
              //         textWidget,
              //       ],
              //     ),
              //   ),
              // if (!fillParentWidth)
               textWidget,
            ],
          ),
        ),
      ),
    );
  }
}
