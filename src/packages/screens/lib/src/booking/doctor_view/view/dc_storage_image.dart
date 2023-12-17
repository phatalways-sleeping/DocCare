import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCStorageImage extends StatefulWidget {
  const DCStorageImage({
    super.key,
    required this.imgPath,
  });

  final String imgPath;

  @override
  State<DCStorageImage> createState() => _DCStorageImageState();
}

class _DCStorageImageState extends State<DCStorageImage> {
  @override
  Widget build(BuildContext context) {
    final loadingWidget = SizedBox(
      height: context.height * 0.15,
      width: context.width * 0.2,
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
        const Duration(seconds: 2),
        () => 'https://picsum.photos/200/300',
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              snapshot.data!,
              height: context.width * 0.3,
              width: context.width * 0.3,
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
