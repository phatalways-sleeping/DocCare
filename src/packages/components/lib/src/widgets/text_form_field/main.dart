import 'package:components/src/theme/color_scheme/light_color_scheme.dart';
import 'package:components/src/widgets/text_form_field/base_text_form_field.dart';
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
        child: BaseTextFormField(
          labelText: 'Label',
          hintText: 'Hint',
          helperText: 'Helper',
          color: context.colorScheme.primary,
          inputBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: context.colorScheme.primary,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          
        ),
      ),
    );
  }
}
