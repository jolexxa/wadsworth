import 'package:flutter/material.dart';
import 'package:wadsworth/app/utility.dart';
import 'package:wadsworth/models/models.dart';
import 'package:wadsworth/widgets/widgets.dart';

class LifelogEntrySummary extends StatelessWidget {
  LifelogEntrySummary({Key key, @required this.lifelog}) : super(key: key);

  final Lifelog lifelog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.lightbulb_outline, color: theme.accentColor),
          title: Text(
            prettyDate(lifelog.timestamp),
            style: TextStyle(fontSize: 18),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Column(
            children: [
              Row(children: [
                LifelogFieldText('Mood'),
                LifelogFieldText(moodToEmoji((lifelog.mood)))
              ]),
              Row(
                children: [
                  LifelogFieldText('Thoughts'),
                  Text(lifelog.thoughts),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
