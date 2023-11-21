// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  final DCHeaderBarItem? leadingItems;
  final List<DCHeaderBarItem>? actionItems;
  final String? headerBarTitle;
  final double widthFactor;
  final double cornerRadius;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  State<BaseHeaderBar> createState() => _BaseHeaderBarState();
}

class _BaseHeaderBarState extends State<BaseHeaderBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: widget.widthFactor,
        heightFactor: 1,
        child: AppBar(
          backgroundColor:
              widget.backgroundColor ?? context.colorScheme.background,
          centerTitle: true,
          title: Text(widget.headerBarTitle ?? ""),
          leading: widget.leadingItems,
          actions: widget.actionItems,
        ),
      ),
    );
  }
}

/// [DCHeaderBarItem] is the class for each item in the HeaderBar
/// To insert an item in the HeaderBar, create an instance of this class
class DCHeaderBarItem extends StatelessWidget {
  /// Constructor for the HeaderBar item
  const DCHeaderBarItem({
    this.title,
    this.selected = false,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
    this.contentPadding,
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    this.textColor,
    this.tileColor,
    this.selectedTileColor,
    this.leadingAndTrailingTextStyle,
    this.titleTextStyle,
    this.splashColor,
    this.focusColor,
    this.selectedBackgroundColor,
    this.horizontalTitleGap,
    this.onTap,
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? title;

  final EdgeInsetsGeometry? contentPadding;

  final BorderRadius borderRadius;

  final Color? iconColor;
  final Color? textColor;
  final Color? tileColor;
  final Color? splashColor;
  final Color? focusColor;
  final Color? selectedTileColor;
  final Color? selectedBackgroundColor;

  final TextStyle? leadingAndTrailingTextStyle;
  final TextStyle? titleTextStyle;

  final bool selected;

  final double? horizontalTitleGap;

  final void Function(BuildContext context)? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap?.call(context),
      selected: selected,
      splashColor: splashColor ?? context.colorScheme.tertiary.withOpacity(0.5),
      focusColor: focusColor ?? context.colorScheme.tertiary.withOpacity(0.5),
      horizontalTitleGap: horizontalTitleGap ?? 0,
      leadingAndTrailingTextStyle:
          leadingAndTrailingTextStyle ?? context.textTheme.h5RegularPoppins,
      titleTextStyle: titleTextStyle ?? context.textTheme.h5RegularPoppins,
      textColor: textColor ?? context.colorScheme.onBackground,
      tileColor: tileColor ?? context.colorScheme.background,
      iconColor: iconColor ?? context.colorScheme.onBackground,
      selectedTileColor:
          selectedBackgroundColor ?? context.colorScheme.tertiary,
      selectedColor: selectedTileColor ?? context.colorScheme.background,
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: context.width * 0.05,
            vertical: context.height * 0.01,
          ),
      leading: prefixIcon,
      trailing: suffixIcon ??
          const SizedBox.square(
            dimension: 30,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      title: title,
    );
  }
}
