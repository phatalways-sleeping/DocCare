import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCButton extends StatelessWidget {
  const DCButton({
    super.key,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.borderColor,
    this.backgroundColor,
    this.foregroundColor,
    this.textColor,
    this.iconColor,
    this.iconLeft,
    this.iconRight,
    this.imageLeft,
    this.imageRight,
    this.widgetLeft,
    this.widgetRight,
    this.fillParentWidth = false,
    this.padding,
    this.gapBetweenElements,
    this.borderRadius,
    this.textSize,
    this.borderWidth,
    this.pressedOpacity,
    this.hoveredOpacity,
    this.iconSize,
  });

  final void Function()? onPressed;
  final Color? iconColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final String text;
  final IconData? iconLeft;
  final IconData? iconRight;
  final AssetImage? imageLeft;
  final AssetImage? imageRight;
  final Widget? widgetLeft;
  final Widget? widgetRight;
  final bool fillParentWidth;
  final EdgeInsetsGeometry? padding;
  final double? gapBetweenElements;
  final double? borderRadius;
  final double? textSize;
  final double? borderWidth;
  final double? pressedOpacity;
  final double? hoveredOpacity;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      text,
      style: textStyle ??
          context.textTheme.h6RegularPoppins.copyWith(
            color: textColor ?? Colors.black,
            fontSize: this.textSize ?? 14,
          ),
      //maxLines: ButtonConfig.maxLines,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 80.0),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          side: MaterialStateProperty.resolveWith((states) {
            double width = borderWidth ?? 1.0;
            final borderColor =
                this.borderColor ?? Colors.black;
            if (states.contains(MaterialState.disabled)) {
              return BorderSide(
                color: Color(0xFFB9B9B9),
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
            final backgroundColor = this.backgroundColor ?? Colors.greenAccent;
            if (states.contains(MaterialState.disabled)) {
              // TODO(sxweetlollipop2912): replace with color theme gray/03
              return const Color(0xFFB9B9B9);
            } else if (states.contains(MaterialState.pressed)) {
              return backgroundColor.withOpacity(this.pressedOpacity ?? 0.5);
            } else if (states.contains(MaterialState.hovered)) {
              return backgroundColor.withOpacity(this.hoveredOpacity ?? 0.8);
            }
            return backgroundColor;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.white;
            } else {
              return foregroundColor;
            }
          }),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(this.borderRadius ?? 80),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0,
              ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (iconLeft != null)
                Icon(
                  iconLeft,
                  size: this.iconSize ?? 14,
                  color: iconColor,
                ),
              if (imageLeft != null)
                Image(
                  image: imageLeft!,
                  width: this.iconSize ?? 14,
                  height: this.iconSize ?? 14,
                  fit: BoxFit.scaleDown,
                ),
              if (widgetLeft != null) widgetLeft!,
              SizedBox(
                width: iconLeft != null ||
                        imageLeft != null ||
                        widgetLeft != null
                    ? gapBetweenElements ?? 10
                    : 0,
              ),
              if (fillParentWidth)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      textWidget,
                    ],
                  ),
                ),
              if (!fillParentWidth) textWidget,
              SizedBox(
                width: iconRight != null ||
                        imageRight != null ||
                        widgetRight != null
                    ? gapBetweenElements ?? 10
                    : 0,
              ),
              if (iconRight != null)
                Icon(
                  iconRight,
                  size: this.iconSize ?? 14,
                  color: iconColor,
                ),
              if (imageRight != null)
                Image(
                  image: imageRight!,
                  width: this.iconSize ?? 14,
                  height: this.iconSize ?? 14,
                  fit: BoxFit.scaleDown,
                ),
              if (widgetRight != null) widgetRight!,
            ],
          ),
        ),
      ),
    );
  }
}
