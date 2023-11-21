// ignore_for_file: public_member_api_docs

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class BaseHeaderBar extends StatefulWidget implements PreferredSizeWidget {
  const BaseHeaderBar({
    this.headerBarTitle,
    this.leadingItems,
    this.actionItems,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    super.key,
  }) : assert(
          widthFactor >= 0.5 && widthFactor <= 0.95,
          'widthFactor must be between 0.5 and 0.95',
        );
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Widget? leadingItems;
  final List<Widget>? actionItems;
  final String? headerBarTitle;
  final double widthFactor;
  final double cornerRadius;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<BaseHeaderBar> createState() => _BaseHeaderBarState();
}

class _BaseHeaderBarState extends State<BaseHeaderBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AppBar(
        backgroundColor:
            widget.backgroundColor ?? context.colorScheme.background,
        centerTitle: true,
        title: Text(widget.headerBarTitle ?? ""),
        leading: widget.leadingItems,
        actions: widget.actionItems,
      ),
    );
  }
}
