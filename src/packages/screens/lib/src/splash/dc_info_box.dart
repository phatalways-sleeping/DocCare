import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// {@template dc_information_box}
class DCInformationBox extends StatelessWidget {
  /// {@macro dc_information_box}
  const DCInformationBox({
    required this.header,
    required this.body,
    required this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.shape = BoxShape.rectangle,
    this.footer,
    this.border,
    this.gradient,
    super.key,
  });

  final Widget header;
  final Widget body;
  final Widget? footer;

  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Border? border;
  final Gradient? gradient;
  final BoxShape shape;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      constraints: BoxConstraints(
        maxWidth: context.width * 0.45,
        maxHeight: context.height * 0.18,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        border: border,
        gradient: gradient,
        shape: shape,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DefaultTextStyle.merge(
            style: context.textTheme.h1RegularPoppins.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            child: header,
          ),
          DefaultTextStyle.merge(
            style: context.textTheme.h2RegularPoppins.copyWith(
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            child: body,
          ),
          DefaultTextStyle.merge(
            style: context.textTheme.h2RegularPoppins.copyWith(
              fontSize: 12,
            ),
            textAlign: TextAlign.right,
            child: footer ?? const SizedBox(),
          ),
        ],
      ),
    );
  }
}
