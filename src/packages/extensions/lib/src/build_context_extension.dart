import 'package:flutter/material.dart';

/// {@template extensions}
/// Packages for extensions used in the project
/// {@endtemplate}
extension BuildContextExtension on BuildContext {
  /// {@macro build_context_extension}
  Size get size => MediaQuery.sizeOf(this);

  /// {@macro build_context_extension}
  bool get isPortrait => size.height > size.width;

  /// {@macro build_context_extension}
  bool get isLandscape => size.width > size.height;

  /// {@macro build_context_extension}
  bool isMobile([double width = 600]) => size.width < width;

  /// {@macro build_context_extension}
  bool isTablet([double width = 950]) =>
      size.width >= width && size.width < 1200;

  /// {@macro build_context_extension}
  bool isDesktop([double width = 1200]) => size.width >= width;

  /// {@macro build_context_extension}
  ThemeData get theme => Theme.of(this);

  /// {@macro build_context_extension}
  TextTheme get textTheme => theme.textTheme;

  /// {@macro build_context_extension}
  ColorScheme get colorScheme => theme.colorScheme;

  /// {@macro build_context_extension}
  TextDirection get textDirection => Directionality.of(this);

  /// {@macro build_context_extension}
  double get width => size.width;

  /// {@macro build_context_extension}
  double get height => size.height;

  /// {@macro build_context_extension}
  double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

  /// {@macro build_context_extension}
  double get pixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// {@macro build_context_extension}
  double get statusBarHeight => MediaQuery.paddingOf(this).top;

  /// {@macro build_context_extension}
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;

  /// {@macro build_context_extension}
  double get viewInsetsBottom => MediaQuery.viewInsetsOf(this).bottom;

  /// {@macro build_context_extension}
  double get viewInsetsTop => MediaQuery.viewInsetsOf(this).top;

  /// {@macro build_context_extension}
  double get viewInsetsLeft => MediaQuery.viewInsetsOf(this).left;

  /// {@macro build_context_extension}
  double get viewInsetsRight => MediaQuery.viewInsetsOf(this).right;

  /// {@macro build_context_extension}
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
}
