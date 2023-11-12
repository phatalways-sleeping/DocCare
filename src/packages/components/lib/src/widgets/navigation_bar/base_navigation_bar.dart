// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

base class BaseNavigationBar extends StatefulWidget {
  const BaseNavigationBar({
    required this.onItemSelected,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.navBarItems,
    required this.selectedIndex,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    super.key,
  });

  final List<BottomNavigationBarItem> navBarItems;
  final int selectedIndex;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double widthFactor;
  final double cornerRadius;
  final void Function(BuildContext context, String typeUser, int index)
      onItemSelected;

  @override
  State<BaseNavigationBar> createState() => _BaseNavigationBarState();
}

class _BaseNavigationBarState extends State<BaseNavigationBar> {
  @override
  Widget build(BuildContext context) {
    String typeUser = 'base';
    int selectedIndex = widget.selectedIndex;

    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.cornerRadius)),
        child: FractionallySizedBox(
          widthFactor: widget.widthFactor,
          child: BottomNavigationBar(
            items: widget.navBarItems,
            currentIndex: selectedIndex,
            selectedItemColor: widget.selectedItemColor,
            unselectedItemColor: widget.unselectedItemColor,
            onTap: (index) => setState(() {
              selectedIndex = index;
              widget.onItemSelected(context, typeUser, index);
            }),
            backgroundColor: widget.backgroundColor,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
          ),
        ),
      ),
    );
  }
}
