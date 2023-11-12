import 'dart:ui';
import 'package:components/components.dart';
import 'package:flutter/material.dart';

class DCCustomerHeaderBar extends BaseHeaderBar {
  DCCustomerHeaderBar({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    required HeaderIconType iconType,
    VoidCallback? onNotificationPressed,
  }) : super(
          key: key,
          title: title,
          onPressed: onPressed,
          iconType: iconType,
          onNotificationPressed: onNotificationPressed,
        );
}
