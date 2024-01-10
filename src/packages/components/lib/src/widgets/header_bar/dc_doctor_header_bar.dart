// ignore_for_file: public_member_api_docs, unused_local_variable
import 'package:components/components.dart';
import 'package:components/src/widgets/header_bar/base_header_bar.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCDoctorHeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const DCDoctorHeaderBar({
    super.key,
    this.title,
    this.onLeadingIconPressed,
    this.onActionsIconPressed,
    this.backgroundColor,
    this.cornerRadius = 40,
    this.allowNavigateBack = false,
    this.haveLogout = false,
    this.haveNotification = false,
  });
  final String? title;
  final bool haveLogout;
  final bool allowNavigateBack;
  final bool haveNotification;
  final double cornerRadius;
  final void Function(BuildContext context)? onLeadingIconPressed;
  final void Function(BuildContext context)? onActionsIconPressed;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<DCDoctorHeaderBar> createState() => _DCDoctorHeaderBarState();
}

class _DCDoctorHeaderBarState extends State<DCDoctorHeaderBar> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? context.colorScheme.background;
    final haveNotification = widget.haveNotification;
    final title = widget.title ?? '';

    return BaseHeaderBar(
      headerBarTitle: title,
      backgroundColor: backgroundColor,
      leadingItems: widget.allowNavigateBack
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
                widget.onLeadingIconPressed?.call(context);
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
                    widget.onLeadingIconPressed?.call(context);
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
              widget.onActionsIconPressed?.call(context);
            },
          ),
      ],
    );
  }
}
