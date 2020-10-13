import 'package:flutter/material.dart';
import 'package:wadsworth/app/callbacks.dart';
import 'package:wadsworth/app/keys.dart';
import 'package:wadsworth/app/utility.dart';
import 'package:wadsworth/models/models.dart';

class LifelogMood extends StatefulWidget {
  /// The mood that should be selected by default
  final Mood initialMood;

  /// Callback for when a mood has been selected
  final UpdateMoodCallback onMoodSelected;

  LifelogMood({
    Key key,
    @required this.initialMood,
    @required this.onMoodSelected,
  }) : super(key: key);
  @override
  _LifelogMoodState createState() => _LifelogMoodState();
}

class _LifelogMoodState extends State<LifelogMood> {
  int _selectedMoodIndex;

  @override
  void initState() {
    _selectedMoodIndex = Mood.values.indexOf(widget.initialMood);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chips = <Widget>[];
    final theme = Theme.of(context);

    for (var i = 0; i < Mood.values.length; i++) {
      final mood = Mood.values[i];
      final choiceChip = Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: ChoiceChip(
          key: LIFELOG_MOOD_CHIP_KEYS[mood],
          selected: _selectedMoodIndex == i,
          label: Text(moodToEmoji(mood), style: TextStyle(fontSize: 24.0)),
          elevation: 3,
          pressElevation: 5,
          backgroundColor: Colors.black54,
          selectedColor: theme.accentColor,
          onSelected: (bool selected) {
            setState(() {
              _selectedMoodIndex = i;
              widget.onMoodSelected(Mood.values[_selectedMoodIndex]);
            });
          },
        ),
      );
      chips.add(
        choiceChip,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: chips,
    );
  }
}
