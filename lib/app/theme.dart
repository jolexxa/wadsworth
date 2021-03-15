import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    final originalTheme = ThemeData.dark();
    final originalTextTheme = originalTheme.textTheme;
    final originalBody1 = originalTextTheme.bodyText1;
    final originalTextSelectionTheme = originalTheme.textSelectionTheme;

    return originalTheme.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.grey[800],
      accentColor: Colors.teal[200],
      buttonColor: Colors.grey[800],
      textSelectionTheme: originalTextSelectionTheme.copyWith(
        selectionColor: Colors.teal[100],
      ),
      backgroundColor: Colors.grey[800],
      toggleableActiveColor: Colors.teal[300],
      textTheme: originalTextTheme.copyWith(
        bodyText2: originalBody1.copyWith(
          decorationColor: Colors.transparent,
        ),
      ),
    );
  }
}
