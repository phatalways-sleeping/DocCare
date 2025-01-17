import 'package:components/src/widgets/animation/base_animated_box.dart';
import 'package:flutter/material.dart';

/// [SlideAnimatedBox] is widget for sliding animation
final class SlideAnimatedBox extends AnimatedBox {
  /// Constructor for [SlideAnimatedBox]
  const SlideAnimatedBox({
    required super.child,
    required this.begin,
    required this.end,
    super.duration = const Duration(milliseconds: 1000),
    this.repeat = false,
    super.curve = Curves.decelerate,
    this.textDirection,
    super.key,
  });

  /// {@macro begin}
  final Offset begin;

  /// {@macro end}
  final Offset end;

  /// {@macro textDirection}
  final TextDirection? textDirection;

  /// {@macro repeat}
  final bool repeat;

  @override
  State<SlideAnimatedBox> createState() => _SlideAnimatedBoxState();
}

class _SlideAnimatedBoxState extends State<SlideAnimatedBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController parentController = AnimationController(
    duration: widget.duration,
    vsync: this,
  );

  late final CurvedAnimation parentAnimation = CurvedAnimation(
    parent: parentController,
    curve: widget.curve,
  );

  late final Animation<Offset> animation = Tween<Offset>(
    begin: widget.begin,
    end: widget.end,
  ).animate(parentAnimation);

  @override
  void initState() {
    if (widget.repeat) {
      parentController.repeat(
        reverse: true,
      );
    } else {
      parentController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    parentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      textDirection: widget.textDirection,
      child: widget.child,
    );
  }
}
