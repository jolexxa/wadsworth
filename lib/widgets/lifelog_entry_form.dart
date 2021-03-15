import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadsworth/app/keys.dart';
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
  Mood _selectedMood = Mood.Meh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lifelogBloc = BlocProvider.of<LifelogBloc>(context);

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
            child: LifelogCard(
              child: Form(
                key: _formKey,
                autovalidateMode: _shouldAutovalidate
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
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
                                child: LifelogMood(
                                  initialMood: Mood.Meh,
                                  onMoodSelected: (mood) {
                                    _selectedMood = mood;
                                  },
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
                                      key: LIFELOG_ENTRY_THOUGHTS_TEXTFORMFIELD,
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
                              key: LIFELOG_ENTRY_ADD_BUTTON,
                              child: Text('SUBMIT'),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  Navigator.of(context).pop();
                                  final thoughts = _thoughtsController.text;
                                  final mood = _selectedMood;
                                  final lifelog =
                                      Lifelog(mood: mood, thoughts: thoughts);
                                  lifelogBloc.add(LifelogAdded(lifelog));
                                } else {
                                  // Remind user to fix errors.
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
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
        ],
      ),
    );
  }
}
