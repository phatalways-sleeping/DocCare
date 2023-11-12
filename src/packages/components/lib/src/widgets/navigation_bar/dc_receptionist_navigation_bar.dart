// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:components/src/widgets/navigation_bar/base_navigation_bar.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Navigation bar for the doctor user type.
/// This navigation bar is used in the doctor screens.
class DCReceptionistNavigationBar extends StatelessWidget {
  const DCReceptionistNavigationBar({
    required this.onItemSelected,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    super.key,
  });

  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double widthFactor;
  final double cornerRadius;

  final void Function(BuildContext context, String typeUser, int index)
      onItemSelected;

  @override
  Widget build(BuildContext context) {
    var selectedIndex = 0;
    var navBarItems = <BottomNavigationBarItem>[];

    final backColor = backgroundColor ?? context.colorScheme.primary;

    final chooseColor = selectedItemColor ?? context.colorScheme.onPrimary;

    final unChooseColor = unselectedItemColor ?? context.colorScheme.quinary;

    navBarItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.string(
          DCSVGIcons.home,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            selectedIndex == 0 ? chooseColor : unChooseColor,
            BlendMode.srcIn,
          ),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.string(
          DCSVGIcons.profile,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            selectedIndex == 1 ? chooseColor : unChooseColor,
            BlendMode.srcIn,
          ),
        ),
        label: 'Profile',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.string(
          DCSVGIcons.booking,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            selectedIndex == 2 ? chooseColor : unChooseColor,
            BlendMode.srcIn,
          ),
        ),
        label: 'Booking',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.string(
          DCSVGIcons.messages,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            selectedIndex == 3 ? chooseColor : unChooseColor,
            BlendMode.srcIn,
          ),
        ),
        label: 'Messages',
      ),
    ];

    return BaseNavigationBar(
      onItemSelected: onItemSelected,
      backgroundColor: backColor,
      selectedItemColor: chooseColor,
      unselectedItemColor: unChooseColor,
      widthFactor: widthFactor,
      cornerRadius: cornerRadius,
      navBarItems: navBarItems,
      selectedIndex: selectedIndex,
    );
  }
}
