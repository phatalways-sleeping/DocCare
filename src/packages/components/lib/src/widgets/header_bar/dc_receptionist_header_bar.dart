// ignore_for_file: public_member_api_docs, unused_local_variable
import 'package:components/components.dart';
import 'package:components/src/widgets/header_bar/base_header_bar.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCReceptionistHeaderBar extends StatefulWidget
    implements PreferredSizeWidget {
  const DCReceptionistHeaderBar({
    super.key,
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
  final bool haveLogout;
  final bool haveBack;
  final bool haveNotification;
  final double widthFactor;
  final double cornerRadius;
  final void Function(BuildContext context)? onLeadingIconPressed;
  final void Function(BuildContext context)? onActionsIconPressed;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<DCReceptionistHeaderBar> createState() =>
      _DCReceptionistHeaderBarState();
}

class _DCReceptionistHeaderBarState extends State<DCReceptionistHeaderBar> {
  // This is temporary solution for the drawer item selection
  // Later we will use the BLoC to handle the state
  bool leadingSelected = false;
  bool actionSelected = false;

  @override
  Widget build(BuildContext context) {
    final backColor = widget.backgroundColor ?? context.colorScheme.background;
    final chooseColor =
        widget.selectedItemColor ?? context.colorScheme.onPrimary;
    final unChooseColor =
        widget.unselectedItemColor ?? context.colorScheme.quinary;
    final haveNotification = widget.haveNotification;
    final headerBarTitle = widget.headerBarTitle ?? "xcsada";

    return BaseHeaderBar(
      headerBarTitle: headerBarTitle,
      backgroundColor: backColor,
      leadingItems: widget.haveBack
          ? InkWell(
              onTap: () {
                widget.onLeadingIconPressed?.call(context);

                setState(() {
                  leadingSelected = true;
                  actionSelected = false;
                });
              },
              child: SvgPicture.string(
                DCSVGIcons.back,
                fit: BoxFit.cover,
                height: 24,
                width: 24,
              ),
            )
          : widget.haveLogout
              ? InkWell(
                  onTap: () {
                    widget.onLeadingIconPressed?.call(context);

                    setState(() {
                      leadingSelected = true;
                      actionSelected = false;
                    });
                  },
                  child: SvgPicture.string(
                    DCSVGIcons.logout,
                    fit: BoxFit.cover,
                    height: 24,
                    width: 24,
                  ),
                )
              : null,
      actionItems: haveNotification
          ? [
              InkWell(
                onTap: () {
                  widget.onLeadingIconPressed?.call(context);

                  setState(() {
                    leadingSelected = false;
                    actionSelected = true;
                  });
                },
                child: SvgPicture.string(
                  DCSVGIcons.notification,
                  fit: BoxFit.cover,
                  height: 24,
                  width: 24,
                ),
              )
            ]
          : [],
    );
  }
}
