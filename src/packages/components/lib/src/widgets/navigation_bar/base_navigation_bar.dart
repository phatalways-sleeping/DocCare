// ignore_for_file: public_member_api_docs

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

base class BaseNavigationBar extends StatelessWidget {
  const BaseNavigationBar({
    required this.onItemSelected,
    required this.navBarItems,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIndex = 0,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    this.bottomPadding = 8.0,
    super.key,
  });

  final List<BottomNavigationBarItem> navBarItems;
  final int selectedIndex;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double widthFactor;
  final double cornerRadius;
  final double bottomPadding;
  final void Function(BuildContext context, int index) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            child: BottomNavigationBar(
              items: navBarItems,
              currentIndex: selectedIndex,
              selectedItemColor:
                  selectedItemColor ?? context.colorScheme.onPrimary,
              unselectedItemColor:
                  unselectedItemColor ?? context.colorScheme.quinary,
              onTap: (index) => onItemSelected(context, index),
              backgroundColor: backgroundColor ?? context.colorScheme.tertiary,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          ),
        ),
      ),
    );
  }
}
