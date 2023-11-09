import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DCHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const DCHeaderBar({
    Key? key,
    required this.title,
    this.onDrawerPressed,
    this.onNotificationPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback? onDrawerPressed;
  final VoidCallback? onNotificationPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          DCSVGIcons.drawer,
          height: 24,
          width: 24,
        ),
        onPressed: onDrawerPressed,
      ),
      title: Text(
        title,
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
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 50.0);
}
