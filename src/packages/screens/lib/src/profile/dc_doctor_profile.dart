import 'dart:io';

import 'package:components/components.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:components/src/widgets/text_form_field/dc_outlined_with_heading_text_form_field.dart';
import 'package:components/src/widgets/button/dc_outlined_button.dart';
import 'package:components/src/widgets/button/dc_filled_button.dart';

class DCDoctorProfile extends StatefulWidget {
  const DCDoctorProfile({
    this.textController,
  });

  final TextEditingController? textController;

  @override
  _DCDoctorProfileState createState() => _DCDoctorProfileState();
}

class _DCDoctorProfileState extends State<DCDoctorProfile> {
  late double height = context.height * 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: context.colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.05,
                  vertical: context.height * 0.05,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DCOutlinedWithHeadingTextFormField(
                      heading: DefaultTextStyle.merge(
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color: context.colorScheme.tertiary,
                        ),
                        child: const Text('Fullname'),
                      ),
                      textAlign: TextAlign.center,
                      controller: widget.textController,
                      initialText: 'John Doe',
                      textFormFieldConstraints: BoxConstraints(
                        maxWidth: context.width * 0.9,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                        vertical: context.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    DCOutlinedWithHeadingTextFormField(
                      heading: DefaultTextStyle.merge(
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color: context.colorScheme.tertiary,
                        ),
                        child: const Text('Email'),
                      ),
                      textAlign: TextAlign.center,
                      controller: widget.textController,
                      initialText: 'john@gmail.com',
                      textFormFieldConstraints: BoxConstraints(
                        maxWidth: context.width * 0.9,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                        vertical: context.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    DCOutlinedWithHeadingTextFormField(
                      heading: DefaultTextStyle.merge(
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color: context.colorScheme.tertiary,
                        ),
                        child: const Text('Birthday'),
                      ),
                      textAlign: TextAlign.center,
                      controller: widget.textController,
                      initialText: '23/07/1999',
                      textFormFieldConstraints: BoxConstraints(
                        maxWidth: context.width * 0.9,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                        vertical: context.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    DCOutlinedWithHeadingTextFormField(
                      heading: DefaultTextStyle.merge(
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color: context.colorScheme.tertiary,
                        ),
                        child: const Text('Phone Number'),
                      ),
                      textAlign: TextAlign.center,
                      controller: widget.textController,
                      initialText: '0123456789',
                      textFormFieldConstraints: BoxConstraints(
                        maxWidth: context.width * 0.9,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                        vertical: context.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    DCOutlinedWithHeadingTextFormField(
                      heading: DefaultTextStyle.merge(
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color: context.colorScheme.tertiary,
                        ),
                        child: const Text('Specialization'),
                      ),
                      textAlign: TextAlign.center,
                      controller: widget.textController,
                      initialText: 'Psychology',
                      textFormFieldConstraints: BoxConstraints(
                        maxWidth: context.width * 0.9,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                        vertical: context.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    DCOutlinedWithHeadingTextFormField(
                      heading: DefaultTextStyle.merge(
                        style: context.textTheme.h6RegularPoppins.copyWith(
                          color: context.colorScheme.tertiary,
                        ),
                        child: const Text('Starting year'),
                      ),
                      textAlign: TextAlign.center,
                      controller: widget.textController,
                      initialText: '1990',
                      textFormFieldConstraints: BoxConstraints(
                        maxWidth: context.width * 0.9,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.03,
                        vertical: context.height * 0.02,
                      ),
                    ),
                    SizedBox(
                      height: context.height * 0.05,
                    ),
                    DCOutlinedButton(
                      onPressed: (context) {},
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.05,
                        vertical: 8,
                      ),
                      fixedSize: Size(
                        context.width * 0.9,
                        context.height * 0.05,
                      ),
                      borderSide: BorderSide(
                        color: context.colorScheme.onBackground,
                      ),
                      foregroundColor: context.colorScheme.background,
                      child: DefaultTextStyle.merge(
                        style: context.textTheme.bodyRegularPoppins.copyWith(
                          color: context.colorScheme.background,
                          fontSize: 16,
                        ),
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
