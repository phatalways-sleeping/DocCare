import 'package:components/components.dart';
import 'package:components/src/widgets/drawer/base_drawer.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// [DCCustomerDrawer] is the drawer for the customer role
class DCCustomerDrawer extends StatefulWidget {
  /// Constructor for the customer drawer
  const DCCustomerDrawer({
    super.key,
    this.onProfileSelected,
    this.onIntakeHistorySelected,
    this.onSignOutSelected,
    this.althernativeHeaderImagePath,
    this.borderRadiusOfEachItem = const BorderRadius.only(
      topRight: Radius.circular(16),
      bottomRight: Radius.circular(16),
    ),
    this.iconSize = 28,
    this.fontSize = 18,
    this.showHeaderImage = true,
    this.fetchByNetwork = false,
    this.widthFactor = 0.8,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(40),
      bottomRight: Radius.circular(40),
    ),
    this.selectedTileColor,
    this.selectedBackgroundColor,
    this.side = BorderSide.none,
    this.elevation = 24,
    this.backgroundColor,
    this.surfaceTintColor,
    this.semanticLabel = 'Drawer',
    this.clipBehavior = Clip.antiAliasWithSaveLayer,
  })  : assert(
          !fetchByNetwork || (althernativeHeaderImagePath != null),
          'Cannot fetch by network without alternative header image path',
        ),
        assert(
          !fetchByNetwork || showHeaderImage,
          'Cannot fetch by network without showing header image',
        );

  final BorderRadius borderRadiusOfEachItem;

  final String? althernativeHeaderImagePath;
  final bool showHeaderImage;
  final bool fetchByNetwork;

  final double widthFactor;
  final BorderRadius borderRadius;
  final BorderSide side;

  final double elevation;
  final double iconSize;
  final double fontSize;

  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final Color? selectedTileColor;
  final Color? selectedBackgroundColor;

  final String semanticLabel;
  final Clip clipBehavior;

  final void Function(BuildContext context)? onProfileSelected;
  final void Function(BuildContext context)? onIntakeHistorySelected;
  final void Function(BuildContext context)? onSignOutSelected;

  @override
  State<DCCustomerDrawer> createState() => _DCCustomerDrawerState();
}

class _DCCustomerDrawerState extends State<DCCustomerDrawer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  // This is temporary solution for the drawer item selection
  // Later we will use the BLoC to handle the state
  bool profileSelected = false;
  bool intakeHistorySelected = false;
  bool signOutSelected = false;

  @override
  void initState() {
    super.initState();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDrawer(
      widthFactor: widget.widthFactor,
      borderRadius: widget.borderRadius,
      side: widget.side,
      elevation: widget.elevation,
      backgroundColor: widget.backgroundColor,
      surfaceTintColor: widget.surfaceTintColor,
      semanticLabel: widget.semanticLabel,
      clipBehavior: widget.clipBehavior,
      headerImage: !widget.showHeaderImage
          ? const SizedBox.shrink()
          : widget.fetchByNetwork
              ? Image.network(
                  widget.althernativeHeaderImagePath!,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  opacity: _animationController,
                )
              : Image.asset(
                  'assets/images/pic_3.png',
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  opacity: _animationController,
                ),
      items: [
        DCDrawerItem(
          borderRadius: widget.borderRadiusOfEachItem,
          onTap: (context) {
            widget.onProfileSelected?.call(context);

            setState(() {
              profileSelected = true;
              intakeHistorySelected = false;
              signOutSelected = false;
            });
          },
          selected: profileSelected,
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
          prefixIcon: SvgPicture.string(
            DCSVGIcons.profile,
            fit: BoxFit.cover,
            height: widget.iconSize,
            width: widget.iconSize,
            colorFilter: profileSelected
                ? ColorFilter.mode(
                    widget.selectedBackgroundColor ??
                        context.colorScheme.background,
                    BlendMode.srcIn,
                  )
                : null,
          ),
          selectedTileColor: widget.selectedTileColor,
          selectedBackgroundColor: widget.selectedBackgroundColor,
        ),
        DCDrawerItem(
          borderRadius: widget.borderRadiusOfEachItem,
          onTap: (context) {
            widget.onIntakeHistorySelected?.call(context);
            setState(() {
              profileSelected = false;
              intakeHistorySelected = true;
              signOutSelected = false;
            });
          },
          selected: intakeHistorySelected,
          title: Text(
            'Intake History',
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
          prefixIcon: SvgPicture.string(
            DCSVGIcons.report,
            fit: BoxFit.cover,
            height: widget.iconSize,
            width: widget.iconSize,
            colorFilter: intakeHistorySelected
                ? ColorFilter.mode(
                    widget.selectedBackgroundColor ??
                        context.colorScheme.background,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
        DCDrawerItem(
          borderRadius: widget.borderRadiusOfEachItem,
          onTap: (context) {
            widget.onSignOutSelected?.call(context);

            setState(() {
              profileSelected = false;
              intakeHistorySelected = false;
              signOutSelected = true;
            });
          },
          selected: signOutSelected,
          title: Text(
            'Sign out',
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
          prefixIcon: SvgPicture.string(
            DCSVGIcons.logout,
            fit: BoxFit.cover,
            height: widget.iconSize,
            width: widget.iconSize,
            colorFilter: signOutSelected
                ? ColorFilter.mode(
                    widget.selectedBackgroundColor ??
                        context.colorScheme.background,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
