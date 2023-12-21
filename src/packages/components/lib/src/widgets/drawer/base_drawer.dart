import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

/// This is the base class [BaseDrawer] for the drawer. It is used
/// to create concrete drawer version of each role: admin, customer,
/// doctor, receptionist
class BaseDrawer extends StatefulWidget {
  /// Constructor for the base drawer
  const BaseDrawer({
    super.key,
    this.widthFactor = 0.8,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(40),
      bottomRight: Radius.circular(40),
    ),
    this.side = BorderSide.none,
    this.clipBehavior = Clip.antiAliasWithSaveLayer,
    this.semanticLabel = 'Drawer',
    this.backgroundColor,
    this.elevation = 24,
    this.surfaceTintColor,
    this.headerImage,
    this.items = const [],
  }) : assert(
          widthFactor >= 0.5 && widthFactor <= 0.95,
          'widthFactor must be between 0.5 and 0.95',
        );

  final double widthFactor;
  final BorderRadius borderRadius;
  final BorderSide side;
  final double elevation;

  final Color? backgroundColor;
  final Color? surfaceTintColor;

  final Widget? headerImage;

  final List<DCDrawerItem> items;

  final String semanticLabel;
  final Clip clipBehavior;

  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
        widthFactor: widget.widthFactor,
        heightFactor: 1, // This is to make the drawer full height
        child: Drawer(
          surfaceTintColor:
              Colors.white, // This is to make the drawer background white
          semanticLabel: widget.semanticLabel,
          clipBehavior: widget.clipBehavior,
          backgroundColor: Colors.white,
          elevation: widget.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius,
            side: widget.side,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.headerImage != null) widget.headerImage!,
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: widget.items,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [DCDrawerItem] is the class for each item in the drawer
/// To insert an item in the drawer, create an instance of this class
class DCDrawerItem extends StatelessWidget {
  /// Constructor for the drawer item
  const DCDrawerItem({
    required this.title,
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
  final Widget title;

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
      title: title,
    );
  }
}
