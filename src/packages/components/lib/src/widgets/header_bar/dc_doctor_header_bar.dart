import 'package:components/components.dart';
import 'package:flutter/material.dart';

class DCDoctorHeaderBar extends BaseHeaderBar {
  const DCDoctorHeaderBar({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    required HeaderIconType iconType,
    VoidCallback? onNotificationPressed,
  }) : super(
          key: key,
          title: title,
          onPressed: onPressed,
          onNotificationPressed: onNotificationPressed,
          iconType: HeaderIconType.drawer, // Specify the icon type
        );
}
