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

  final String imgPath;
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
    final errorWidget = Center(
      child: Icon(
        Icons.error,
        size: 30,
        color: context.colorScheme.error,
      ),
    );
    return FutureBuilder<String>(
      future: Future<String>.delayed(
        Duration(seconds: 2),
        () => widget.imgPath,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              snapshot.data!,
              height: widget.height ?? double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null ? child : loadingWidget,
              errorBuilder: (context, error, stackTrace) => errorWidget,
            ),
          );
        } else if (snapshot.hasError) {
          return errorWidget;
        }
        return loadingWidget;
      },
    );
  }
}
