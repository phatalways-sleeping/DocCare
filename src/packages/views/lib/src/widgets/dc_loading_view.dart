import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class DCLoadingView extends StatefulWidget {
  const DCLoadingView({super.key});

  @override
  State<DCLoadingView> createState() => _DCLoadingViewState();
}

class _DCLoadingViewState extends State<DCLoadingView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: context.height,
        width: context.width,
        color: context.colorScheme.background.withOpacity(0.5),
        alignment: Alignment.center,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: context.colorScheme.primary,
              ),
              const SizedBox(
                height: 10,
              ),
              SlideAnimatedBox(
                begin: const Offset(0, 1),
                end: Offset.zero,
                repeat: true,
                duration: const Duration(
                  milliseconds: 2000,
                ),
                child: Column(
                  children: [
                    Text(
                      'Your request is being processed.',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Please wait...',
                      style: context.textTheme.bodyRegularPoppins.copyWith(
                        fontSize: 16,
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
