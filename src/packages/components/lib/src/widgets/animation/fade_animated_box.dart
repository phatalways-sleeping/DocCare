import 'package:flutter/material.dart';
import 'package:components/src/widgets/animation/animated_box.dart';

/// [FadeAnimatedBox] is widget for fade animation
final class FadeAnimatedBox extends AnimatedBox {
  /// Constructor for [FadeAnimatedBox]
  const FadeAnimatedBox({
    required super.child,
    super.duration = const Duration(milliseconds: 1000),
    super.curve = Curves.decelerate,
    this.startOpacity = 0,
    this.endOpacity = 1,
    super.key,
  })  : assert(
          startOpacity >= 0 && startOpacity <= 1,
          'startOpacity must be between 0 and 1',
        ),
        assert(
          endOpacity >= 0 && endOpacity <= 1,
          'endOpacity must be between 0 and 1',
        );

  /// {@macro startOpacity}
  final double startOpacity;

  /// {@macro endOpacity}
  final double endOpacity;

  @override
  State<FadeAnimatedBox> createState() => _FadeAnimatedBoxState();
}

class _FadeAnimatedBoxState extends State<FadeAnimatedBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController parentController = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  late final CurvedAnimation parentAnimation = CurvedAnimation(
    parent: parentController,
    curve: widget.curve,
  );

  late final Animation<double> opacity = Tween<double>(
    begin: 0,
    end: 1,
  ).animate(parentAnimation);

  @override
  void initState() {
    parentController.forward();
    super.initState();
  }

  @override
  void dispose() {
    parentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: widget.child,
    );
  }
}
