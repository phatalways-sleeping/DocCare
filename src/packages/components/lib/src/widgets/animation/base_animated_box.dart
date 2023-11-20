import 'package:flutter/material.dart';

/// [AnimatedBox] is widget for animated box
abstract base class AnimatedBox extends StatefulWidget {
  /// Constructor for [AnimatedBox]
  const AnimatedBox({
    required this.child,
    required this.duration,
    required this.curve,
    super.key,
  });

  /// {@macro child}
  final Widget child;

  /// {@macro duration}
  final Duration duration;

  /// {@macro curve}
  final Curve curve;
}
