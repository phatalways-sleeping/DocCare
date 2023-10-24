import 'package:flutter/material.dart';


/// {@template DocCareLightColorScheme}
/// Packages for components
/// {@endtemplate}
class DocCareLightColorScheme extends ColorScheme {
  /// {@macro components}
  const DocCareLightColorScheme()
      : super(
          primary: const Color.fromRGBO(139, 240, 180, 0.78),
          secondary: const Color.fromRGBO(194, 209, 252, 1),
          tertiary: const Color.fromRGBO(63, 66, 75, 1),
          surface: const Color.fromRGBO(160, 239, 209, 1),
          background: const Color.fromRGBO(250, 251, 254, 1),
          error: const Color.fromRGBO(244, 204, 183, 1),
          onPrimary: const Color(0xFFFFFFFF),
          onSecondary: const Color(0xFF000000),
          onSurface: const Color(0xFF000000),
          onBackground: const Color(0xFF000000),
          onError: const Color(0xFF000000),
          brightness: Brightness.light,
        );

  /// {@macro quartenary}
  Color get quartenary => const Color.fromRGBO(140, 108, 231, 1);

  /// {@macro quinary}
  Color get quinary => const Color.fromRGBO(142, 141, 145, 1);
}
