// ignore_for_file: public_member_api_docs, unused_local_variable
import 'package:components/components.dart';
import 'package:components/src/widgets/header_bar/base_header_bar.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCAdminHeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const DCAdminHeaderBar({
    Key? key,
    this.headerBarTitle,
    this.onLeadingIconPressed,
    this.onActionsIconPressed,
    this.backgroundColor,
    this.cornerRadius = 40,
    this.allowNavigationBack = false,
    this.haveLogout = false,
    this.haveNotification = false,
  }) : super(key: key);

  final String? headerBarTitle;
  final bool haveLogout;
  final bool allowNavigationBack;
  final bool haveNotification;
  final double cornerRadius;
  final void Function()? onLeadingIconPressed;
  final void Function()? onActionsIconPressed;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<DCAdminHeaderBar> createState() => _DCAdminHeaderBarState();
}

class _DCAdminHeaderBarState extends State<DCAdminHeaderBar> {
  @override
  Widget build(BuildContext context) {
    final backColor = widget.backgroundColor ?? context.colorScheme.background;
    final haveNotification = widget.haveNotification;
    final headerBarTitle = widget.headerBarTitle ?? '';

    return BaseHeaderBar(
      headerBarTitle: headerBarTitle,
      backgroundColor: backColor,
      leadingItems: widget.allowNavigationBack
          ? IconButton(
              icon: SvgPicture.string(
                DCSVGIcons.back,
                width: 30,
                height: 20,
                colorFilter: ColorFilter.mode(
                  context.colorScheme.onBackground,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : widget.haveLogout
              ? IconButton(
                  icon: SvgPicture.string(
                    DCSVGIcons.logout,
                    width: 25,
                    height: 25,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    widget.onLeadingIconPressed?.call();
                  },
                )
              : null,
      actionItems: [
        if (haveNotification)
          IconButton(
            icon: SvgPicture.string(
              DCSVGIcons.notification,
              width: 25,
              height: 25,
              colorFilter: ColorFilter.mode(
                context.colorScheme.onBackground,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              widget.onActionsIconPressed?.call();
            },
          ),
      ],
    );
  }
}
