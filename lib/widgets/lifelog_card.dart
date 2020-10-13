import 'package:flutter/material.dart';

class LifelogCard extends StatelessWidget {
  LifelogCard({@required this.child}) : super();

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: child,
        ),
      ),
    );
  }
}
