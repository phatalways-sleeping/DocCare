// ignore_for_file: public_member_api_docs

import 'dart:html';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCNavigationBar extends StatefulWidget {
  const DCNavigationBar({
    required this.userType,
    required this.onItemSelected,
    required this.backgroundColor,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    this.widthFactor = 0.8,
    this.cornerRadius = 40,
    super.key,
  });

  final String userType;
  final Color backgroundColor;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final double widthFactor;
  final double cornerRadius;
  final void Function(BuildContext context, String typeUser, int index)
      onItemSelected;

  @override
  State<DCNavigationBar> createState() => _DCNavigationBarState();
}

class _DCNavigationBarState extends State<DCNavigationBar> {
  int selectedIndex = 0;
  String typeUser = '';

  @override
  Widget build(BuildContext context) {
    var navBarItems = <BottomNavigationBarItem>[];

    switch (widget.userType) {
      case 'doctor':
        typeUser = 'doctor';
        navBarItems = [
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.home,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 0
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.messages,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 1
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Message',
          ),
        ];
      case 'customer':
        typeUser = 'customer';
        navBarItems = [
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.home,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 0
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.intake,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 1
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Intake',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.doctors,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 2
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Doctor',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.booking,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 3
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
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
                selectedIndex == 4
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Messages',
          ),
        ];
      case 'receptionist':
        typeUser = 'receptionist';
        navBarItems = [
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              DCSVGIcons.home,
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(
                selectedIndex == 0
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
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
                selectedIndex == 1
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
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
                selectedIndex == 2
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
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
                selectedIndex == 3
                    ? widget.selectedItemColor
                    : widget.unselectedItemColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Messages',
          ),
        ];
    }

    return Container(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.cornerRadius)),
        child: SizedBox(
          width: context.width * widget.widthFactor,
          child: BottomNavigationBar(
            items: navBarItems,
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
