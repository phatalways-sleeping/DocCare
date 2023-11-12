import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Enum to represent different types of icons
enum HeaderIconType { drawer, back, logout }

class BaseHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const BaseHeaderBar({
    Key? key,
    required this.title,
    this.onPressed, // Use a single callback for all icons
    required this.iconType,
    this.onNotificationPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback? onPressed; // Use a single callback for all icons
  final HeaderIconType iconType; // Enum to represent the type of icon
  final VoidCallback? onNotificationPressed;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: buildLeadingIcon(), // Use a method to build the leading icon
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: context.textTheme.h6BoldPoppins.fontFamily,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.string(
            DCSVGIcons.notification,
            colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
            height: 24,
            width: 24,
          ),
          onPressed: onNotificationPressed,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 50.0);

  Widget buildLeadingIcon() {
    switch (iconType) {
      case HeaderIconType.drawer:
        return IconButton(
          icon: SvgPicture.string(
            DCSVGIcons.drawer,
            height: 24,
            width: 24,
          ),
          onPressed: onPressed,
        );
      case HeaderIconType.back:
        return IconButton(
          icon: SvgPicture.string(
            DCSVGIcons.back,
            height: 24,
            width: 24,
          ),
          onPressed: onPressed,
        );
      case HeaderIconType.logout:
        return IconButton(
          icon: SvgPicture.string(
            DCSVGIcons.logout,
            height: 24,
            width: 24,
          ),
          onPressed: onPressed,
        );
    }
  }
}

class DCHeaderBarItem extends StatelessWidget {
  const DCHeaderBarItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.selected,
    this.selectedTileColor,
    this.selectedBackgroundColor,
    this.fontSize = 18,
  }) : super(key: key);

  final VoidCallback onTap;
  final String icon;
  final bool selected;
  final Color? selectedTileColor;
  final Color? selectedBackgroundColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? selectedTileColor : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string(
              icon,
              height: 24,
              width: 24,
              color: selected
                  ? selectedBackgroundColor ?? Theme.of(context).primaryColor
                  : null,
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
