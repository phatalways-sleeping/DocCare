// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:views/src/profile/controller/profile_bloc.dart';

class DCAvatarWidget extends StatefulWidget {
  const DCAvatarWidget({super.key});

  @override
  State<DCAvatarWidget> createState() => _DCAvatarWidgetState();
}

class _DCAvatarWidgetState extends State<DCAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          previous.imageUrl != current.imageUrl ||
          previous.imageFile != current.imageFile,
      builder: (context, state) {
        if (state.imageUrl == null && state.imageFile == null) {
          return Image.asset(
            'assets/images/pic_3.png',
            fit: BoxFit.cover,
          );
        }
        final child = state.imageFile != null
            ? Image.file(
                File(state.imageFile!.path),
                fit: BoxFit.cover,
                width: context.width * 0.5,
              )
            : Image.network(
                state.imageUrl!,
                fit: BoxFit.cover,
                width: context.width * 0.5,
              );
        return ClipPath(
          clipper: CustomAvatarClipper(),
          child: child,
        );
      },
    );
  }
}

class CustomAvatarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final radius = size.width / 2;
    path.addOval(
      Rect.fromCircle(
        center: Offset(radius, radius),
        radius: radius,
      ),
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
