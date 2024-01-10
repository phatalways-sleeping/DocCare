// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BaseHeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const BaseHeaderBar({
    this.headerBarTitle,
    this.leadingItems,
    this.actionItems,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.cornerRadius = 40,
    this.hideDrawerIcon = false,
    super.key,
  });
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Widget? leadingItems;
  final List<Widget>? actionItems;
  final String? headerBarTitle;
  final double cornerRadius;
  final bool hideDrawerIcon;

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  State<BaseHeaderBar> createState() => _BaseHeaderBarState();
}

class _BaseHeaderBarState extends State<BaseHeaderBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor ?? context.colorScheme.background,
      centerTitle: true,
      title: Text(
        widget.headerBarTitle ?? '',
        style: context.textTheme.h1BoldPoppins.copyWith(
          color: context.colorScheme.onBackground,
          fontSize: 24,
        ),
      ),
      leading: widget.leadingItems ??
          (widget.hideDrawerIcon
              ? null
              : IconButton(
                  icon: SvgPicture.string(
                    DCSVGIcons.drawer,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      context.colorScheme.onBackground,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )),
      actions: widget.actionItems,
    );
  }
}
