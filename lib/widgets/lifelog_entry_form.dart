import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadsworth/app/utility.dart';
import 'package:wadsworth/blocs/blocs.dart';
import 'package:wadsworth/models/models.dart';
import 'package:wadsworth/widgets/widgets.dart';

class LifelogEntryForm extends StatefulWidget {
  LifelogEntryForm({
    Key key,
  }) : super(key: key);

  @override
  _LifelogEntryFormState createState() => _LifelogEntryFormState();
}

class _LifelogEntryFormState extends State<LifelogEntryForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _thoughtsController = TextEditingController();
  bool _shouldAutovalidate = false;
  int _selectedMoodIndex = 1;

  List<String> get _moodEmojis =>
      Mood.values.map((mood) => moodToEmoji(mood)).toList();

  @override
  Widget build(BuildContext context) {
    var chips = <Widget>[];
    final theme = Theme.of(context);
    final lifelogBloc = BlocProvider.of<LifelogBloc>(context);

    for (var i = 0; i < _moodEmojis.length; i++) {
      final choiceChip = Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: ChoiceChip(
          selected: _selectedMoodIndex == i,
          label: Text(_moodEmojis[i], style: TextStyle(fontSize: 24.0)),
          elevation: 3,
          pressElevation: 5,
          backgroundColor: Colors.black54,
          selectedColor: theme.accentColor,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedMoodIndex = i;
              }
            });
          },
        ),
      );
      chips.add(
        choiceChip,
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            // direction: Axis.vertical,
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Form(
                  key: _formKey,
                  autovalidate: _shouldAutovalidate,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.lightbulb_outline,
                            color: theme.accentColor),
                        title: Text('Store a memory',
                            style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                LifelogFieldText('Mood'),
                                Expanded(
                                  // direction: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: chips,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Row(children: [LifelogFieldText('Thoughts')]),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _thoughtsController,
                                        autofocus: true,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please tell me your secrets!';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText:
                                              '...whatever is on your mind 🤔',
                                        ),
                                        minLines: 1,
                                        maxLines: null,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ButtonBar(
                        children: [
                          ButtonBar(
                            children: [
                              FlatButton(
                                child: Text('SUBMIT'),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print(
                                      'You typed ${_thoughtsController.text}',
                                    );
                                    final thoughts = _thoughtsController.text;
                                    final mood =
                                        Mood.values[_selectedMoodIndex];
                                    final lifelog =
                                        Lifelog(mood: mood, thoughts: thoughts);
                                    lifelogBloc.add(LifelogAdded(lifelog));
                                  } else {
                                    // Remind user to fix errors.
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please correct errors before submitting.',
                                        ),
                                      ),
                                    );
                                  }
                                  setState(() {
                                    _shouldAutovalidate = true;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
