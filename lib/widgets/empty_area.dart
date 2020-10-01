import 'package:flutter/material.dart';

class EmptyArea extends StatelessWidget {
  EmptyArea({@required this.child}) : super();

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [child],
        ),
      ],
    );
  }
}
