// ignore_for_file: public_member_api_docs, unused_local_variable
import 'package:extensions/extensions.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:components/src/widgets/header_bar/base_header_bar.dart';

class DCDoctorHeaderBar extends StatefulWidget {
  const DCDoctorHeaderBar({
    this.headerBarTitle,
    this.onLeadingIconPressed,
    this.onActionsIconPressed,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    this.haveBack = false,
    this.haveLogout = false,
    this.haveNotification = false,
  });
  final String? headerBarTitle;
  final bool? haveLogout;
  final bool? haveBack;
  final bool? haveNotification;
  final double widthFactor;
  final double cornerRadius;
  final void Function(BuildContext context)? onLeadingIconPressed;
  final void Function(BuildContext context)? onActionsIconPressed;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  @override
  State<DCDoctorHeaderBar> createState() => _DCDoctorHeaderBarState();
}

class _DCDoctorHeaderBarState extends State<DCDoctorHeaderBar> {
  // This is temporary solution for the drawer item selection
  // Later we will use the BLoC to handle the state
  bool leadingSelected = false;
  bool actionSelected = false;

  @override
  Widget build(BuildContext context) {
    final backColor = widget.backgroundColor ?? context.colorScheme.primary;
    final chooseColor =
        widget.selectedItemColor ?? context.colorScheme.onPrimary;
    final unChooseColor =
        widget.unselectedItemColor ?? context.colorScheme.quinary;
    final haveNotification = widget.haveNotification;
    final String headerBarTitle = widget.headerBarTitle ?? "";

    return BaseHeaderBar(
      headerBarTitle: headerBarTitle,
      backgroundColor: backColor,
      leadingItems: widget.haveBack == true
          ? DCHeaderBarItem(
              prefixIcon: SvgPicture.string(
                DCSVGIcons.back,
                fit: BoxFit.cover,
                height: 24,
                width: 24,
              ),
              onTap: (context) {
                widget.onLeadingIconPressed?.call(context);

                setState(() {
                  leadingSelected = true;
                  actionSelected = false;
                });
              },
            )
          : widget.haveLogout == true
              ? DCHeaderBarItem(
                  prefixIcon: SvgPicture.string(
                    DCSVGIcons.logout,
                    fit: BoxFit.cover,
                    height: 24,
                    width: 24,
                  ),
                  onTap: (context) {
                    widget.onLeadingIconPressed?.call(context);

                    setState(() {
                      leadingSelected = true;
                      actionSelected = false;
                    });
                  })
              : null,
      actionItems: haveNotification == true
          ? [
              DCHeaderBarItem(
                prefixIcon: SvgPicture.string(
                  DCSVGIcons.notification,
                  fit: BoxFit.cover,
                  height: 24,
                  width: 24,
                ),
                onTap: (context) {
                  widget.onActionsIconPressed?.call(context);

                  setState(() {
                    leadingSelected = false;
                    actionSelected = true;
                  });
                },
              )
            ]
          : [],
    );
  }
}
