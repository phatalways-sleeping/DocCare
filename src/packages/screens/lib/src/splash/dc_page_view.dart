import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:screens/src/splash/dc_info_box.dart';

part 'dc_page_view_one.dart';
part 'dc_page_view_two.dart';


/// {@template dc_page_view}
base class DCPageView extends StatefulWidget {
  /// {@macro dc_page_view}
  const DCPageView({
    required this.background,
    required this.foreground,
    this.alignment = MainAxisAlignment.center,
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

  @override
  State<DCPageView> createState() => _DCPageViewState();
}

class _DCPageViewState extends State<DCPageView>
    with SingleTickerProviderStateMixin {
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: animation,
          child: DefaultTextStyle.merge(
            style: context.textTheme.h1RegularPoppins,
            child: widget.background,
          ),
        ),
        if (widget.action != null)
          Positioned(
            top: context.height * 0.01,
            right: context.width * 0.03,
            child: FadeTransition(
              opacity: animation,
              child: widget.action,
            ),
          ),
        if (widget.bottom != null)
          Positioned(
            bottom: context.height * widget.bottom!,
            child: DefaultTextStyle.merge(
              style: context.textTheme.h1BoldPoppins,
              child: Column(
                mainAxisAlignment: widget.alignment,
                children: widget.foreground,
              ),
            ),
          )
        else
          DefaultTextStyle.merge(
            style: context.textTheme.h1BoldPoppins,
            child: Column(
              mainAxisAlignment: widget.alignment,
              children: widget.foreground,
            ),
          ),
        if (widget.footer != null)
          Positioned(
            bottom: context.height * 0.01,
            child: FadeTransition(
              opacity: animation,
              child: widget.footer,
            ),
          ),
      ],
    );
  }
}
