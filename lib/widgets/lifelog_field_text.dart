import 'package:flutter/material.dart';

class LifelogFieldText extends StatelessWidget {
  final String text;
  LifelogFieldText(this.text);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(right: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: theme.accentColor,
        ),
      ),
    );
  }
}
