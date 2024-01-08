// ignore_for_file: public_member_api_docs

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCAppointmentItem extends StatelessWidget {
  const DCAppointmentItem({
    required this.title,
    required this.bottomLeft,
    required this.bottomRight,
    required this.color,
    required this.onSelected,
    this.onPressed,
    this.isDone = true,
    this.isPast = false,
    super.key,
  });

  final String title;
  final Widget bottomLeft;
  final Widget bottomRight;
  final void Function(BuildContext context) onSelected;
  final void Function(BuildContext context)? onPressed;

  final Color color;
  final bool isDone;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        backgroundColor: MaterialStateProperty.all(
          isDone
              ? context.colorScheme.error.withOpacity(0.2)
              : context.colorScheme.background,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        elevation: MaterialStateProperty.all(4),
        shadowColor: MaterialStateProperty.all(
          context.colorScheme.onSurface.withOpacity(0.5),
        ),
        overlayColor: MaterialStateProperty.all(
          color.withOpacity(0.7),
        ),
        surfaceTintColor: const MaterialStatePropertyAll(
          Colors.transparent,
        ),
        fixedSize: MaterialStatePropertyAll(
          Size(
            context.width * 0.94,
            100,
          ),
        ),
        foregroundColor: MaterialStatePropertyAll(
          context.colorScheme.tertiary,
        ),
        padding: MaterialStateProperty.all(
          EdgeInsets.only(
            right: context.width * 0.03,
          ),
        ),
      ),
      onPressed: onPressed != null ? () => onPressed!(context) : null,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 15,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.bodyRegularPoppins.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: context.colorScheme.tertiary,
                  decoration: isDone ? TextDecoration.lineThrough : null,
                ),
                textAlign: TextAlign.start,
                child: Text(
                  title,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.string(
                          DCSVGIcons.clock,
                          fit: BoxFit.cover,
                          height: 18,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: context.width * 0.45,
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              DefaultTextStyle(
                                style:
                                    context.textTheme.h4RegularPoppins.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: context.colorScheme.tertiary,
                                ),
                                child: bottomLeft,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                      top: 3,
                    ),
                    child: isPast == false ? null : null
                    // : RoundCheckBox(
                    //     checkedColor: context.colorScheme.quinary,
                    //     isChecked: isDone,
                    //     animationDuration: const Duration(
                    //       milliseconds: 200,
                    //     ),
                    //     size: 30,
                    //     onTap: (selected) => onSelected(context),
                    //   ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 4,
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      DefaultTextStyle.merge(
                        style: context.textTheme.h4RegularPoppins.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: context.colorScheme.tertiary,
                        ),
                        textAlign: TextAlign.start,
                        child: bottomRight,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
