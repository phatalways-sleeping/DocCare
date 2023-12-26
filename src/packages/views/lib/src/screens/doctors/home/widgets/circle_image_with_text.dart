import 'package:flutter/material.dart';
import 'package:components/components.dart';
import 'package:extensions/extensions.dart';

class CircleImageWithText extends StatelessWidget {
  final String imagePath;
  final String welcomeText;
  final String name;

  const CircleImageWithText({
    Key? key,
    required this.imagePath,
    required this.welcomeText,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(imagePath),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle.merge(
                style: context.textTheme.h2BoldPoppins.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                  color: context.colorScheme.quinary,
                ),
                textAlign: TextAlign.left,
                child: Text(
                  welcomeText,
                )),
            SizedBox(height: 8),
            DefaultTextStyle.merge(
                style: context.textTheme.h2BoldPoppins.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.left,
                child: Text(
                  name,
                )),
          ],
        ),
      ],
    );
  }
}
