import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadsworth/app/utility.dart';
import 'package:wadsworth/blocs/blocs.dart';
import 'package:wadsworth/models/models.dart';
import 'package:wadsworth/widgets/widgets.dart';

class LifelogEntrySummary extends StatelessWidget {
  LifelogEntrySummary({Key key, @required this.lifelog}) : super(key: key);

  final Lifelog lifelog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lifelogBloc = BlocProvider.of<LifelogBloc>(context);
    return Dismissible(
      key: Key(lifelog.id.toString()),
      onDismissed: (direction) {
        lifelogBloc.add(LifelogRemoved(lifelog));
      },
      child: LifelogCard(
        child: Column(
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
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      moodToEmoji((lifelog.mood)),
                      style: TextStyle(fontSize: 36),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LifelogFieldText('Thoughts'),
                      Text(lifelog.thoughts),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
