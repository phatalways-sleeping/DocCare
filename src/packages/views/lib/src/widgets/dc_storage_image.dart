// ignore_for_file: public_member_api_docs

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCStorageImage extends StatefulWidget {
  const DCStorageImage({
    required this.imgPath,
    super.key,
    this.height,
    this.width,
  });

  final String? imgPath;
  final double? height;
  final double? width;

  @override
  State<DCStorageImage> createState() => _DCStorageImageState();
}

class _DCStorageImageState extends State<DCStorageImage> {
  @override
  Widget build(BuildContext context) {
    final loadingWidget = SizedBox(
      height: widget.height ?? context.height * 0.15,
      width: widget.width ?? context.width * 0.15,
      child: Center(
        child: CircularProgressIndicator(
          color: context.colorScheme.secondary,
        ),
      ),
    );
    final errorWidget = Image.asset(
      'assets/images/doctor_avatar_default.jpg',
      height: widget.height ?? double.infinity,
      fit: BoxFit.cover,
    );

    if (widget.imgPath == null) {
      return errorWidget;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        widget.imgPath!,
        height: widget.height ?? double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) =>
            loadingProgress == null ? child : loadingWidget,
        errorBuilder: (context, error, stackTrace) => errorWidget,
      ),
    );
  }
}
