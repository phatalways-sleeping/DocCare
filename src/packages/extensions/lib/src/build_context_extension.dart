import 'package:flutter/material.dart';

/// {@template extensions}
/// Packages for extensions used in the project
/// {@endtemplate}
extension BuildContextExtension on BuildContext {
  /// {@macro build_context_extension}
  Size get size => MediaQuery.of(this).size;

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
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  /// {@macro build_context_extension}
  double get pixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// {@macro build_context_extension}
  double get statusBarHeight => MediaQuery.of(this).padding.top;
}
