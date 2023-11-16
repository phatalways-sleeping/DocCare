import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/splash/dc_info_box.dart';

part 'dc_page_view_one.dart';
part 'dc_page_view_two.dart';

/// {@template dc_page_view}
base class DCPageView extends StatelessWidget {
  /// {@macro dc_page_view}
  const DCPageView({
    required this.background,
    required this.foreground,
    this.alignment = MainAxisAlignment.center,
    this.duration = const Duration(milliseconds: 500),
    this.footer,
    this.action,
    this.bottom,
    super.key,
  }) : assert(
          footer == null || bottom == null || bottom >= 0.1,
          'bottom must be greater than 0.2',
        );

  final Widget background;
  final List<Widget> foreground;
  final Widget? action;
  final Widget? footer;

  final MainAxisAlignment alignment;

  final double? bottom;

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeAnimatedBox(
          duration: duration,
          curve: Curves.easeIn,
          child: DefaultTextStyle.merge(
            style: context.textTheme.h1RegularPoppins,
            child: background,
          ),
        ),
        if (action != null)
          Positioned(
            top: context.height * 0.01,
            right: context.width * 0.03,
            child: FadeAnimatedBox(
              duration: duration,
              curve: Curves.easeIn,
              child: action!,
            ),
          ),
        if (bottom != null)
          Positioned(
            bottom: context.height * bottom!,
            child: DefaultTextStyle.merge(
              style: context.textTheme.h1BoldPoppins,
              child: Column(
                mainAxisAlignment: alignment,
                children: foreground,
              ),
            ),
          )
        else
          DefaultTextStyle.merge(
            style: context.textTheme.h1BoldPoppins,
            child: Column(
              mainAxisAlignment: alignment,
              children: foreground,
            ),
          ),
        if (footer != null)
          Positioned(
            bottom: context.height * 0.01,
            child: FadeAnimatedBox(
              duration: duration,
              child: footer!,
            ),
          ),
      ],
    );
  }
}
