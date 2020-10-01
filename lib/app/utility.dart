import 'package:intl/intl.dart';
import 'package:wadsworth/models/models.dart';

final Map<Mood, String> _moodEmojis = {
  Mood.Bad: '😡',
  Mood.Meh: '😐',
  Mood.Good: '😁'
};

String moodToEmoji(Mood mood) {
  return _moodEmojis[mood];
}

String prettyDate(DateTime timestamp) {
  return DateFormat.yMMMMd('en_US').format(timestamp) +
      ' at ' +
      DateFormat.jm('en_US').format(timestamp);
}
