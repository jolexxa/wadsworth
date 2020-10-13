library constants;

import 'package:flutter/foundation.dart';
import 'package:wadsworth/models/models.dart';

const LIFELOG_ENTRY_ADD_BUTTON = Key('LIFELOG_ENTRY_ADD_BUTTON');
const LIFELOG_ENTRY_THOUGHTS_TEXTFORMFIELD =
    Key('LIFELOG_ENTRY_THOUGHTS_TEXTFORMFIELD');
const LIFELOG_MOOD_CHIP_KEYS = <Mood, Key>{
  Mood.Bad: Key('LIFELOG_MOOD_CHIP_BAD'),
  Mood.Meh: Key('LIFELOG_MOOD_CHIP_MEH'),
  Mood.Good: Key('LIFELOG_MOOD_CHIP_GOOD'),
};
