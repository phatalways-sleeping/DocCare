// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:components/src/widgets/navigation_bar/base_navigation_bar.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Navigation bar for the doctor user type.
/// This navigation bar is used in the doctor screens.
class DCDoctorNavigationBar extends StatelessWidget {
  const DCDoctorNavigationBar({
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    this.selectedIndex = 0,
    this.iconSize = 24,
    this.bottomPadding = 8.0,
    super.key,
  });

  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final int selectedIndex;
  final double widthFactor;
  final double cornerRadius;
  final double iconSize;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return BaseNavigationBar(
      onItemSelected: (context, index) {
        if (index != selectedIndex) {
          switch (index) {
            case 0:
              Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                '/doctor/home',
              );
            case 1:
              Navigator.of(context, rootNavigator: true).pushReplacementNamed(
                '/doctor/message',
              );
          }
        }
      },
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      widthFactor: widthFactor,
      cornerRadius: cornerRadius,
      navBarItems: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.string(
            DCSVGIcons.home,
            height: iconSize,
            width: iconSize,
            colorFilter: selectedIndex == 0
                ? ColorFilter.mode(
                    selectedItemColor ?? context.colorScheme.onPrimary,
                    BlendMode.srcIn,
                  )
                : ColorFilter.mode(
                    unselectedItemColor ?? context.colorScheme.quinary,
                    BlendMode.srcIn,
                  ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.string(
            DCSVGIcons.messages,
            height: iconSize,
            width: iconSize,
            colorFilter: selectedIndex == 1
                ? ColorFilter.mode(
                    selectedItemColor ?? context.colorScheme.onPrimary,
                    BlendMode.srcIn,
                  )
                : ColorFilter.mode(
                    unselectedItemColor ?? context.colorScheme.quinary,
                    BlendMode.srcIn,
                  ),
          ),
          label: 'Message',
        ),
      ],
      selectedIndex: selectedIndex,
      bottomPadding: bottomPadding,
    );
  }
}
