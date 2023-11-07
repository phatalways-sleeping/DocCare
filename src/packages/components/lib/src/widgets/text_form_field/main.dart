import 'package:components/src/theme/color_scheme/light_color_scheme.dart';
import 'package:components/src/widgets/text_form_field/dc_outlined_text_form_field.dart';
import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: const DocCareLightColorScheme(),
      ),
      home: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DCOutlinedTextFormField(
          labelText: 'Label',
          color: context.colorScheme.primary,
          enabled: false,
          borderWidth: 2,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
