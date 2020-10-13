import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wadsworth/app/keys.dart';
import 'package:wadsworth/models/lifelog.dart';
import 'package:wadsworth/widgets/widgets.dart';

void main() async {
  group('LifelogMood', () {
    testWidgets('instantiates correctly', (tester) async {
      Mood currentMood;
      await tester.pumpWidget(makeTestApp(
        child: LifelogMood(
          initialMood: Mood.Meh,
          onMoodSelected: (newMood) {
            currentMood = newMood;
          },
        ),
      ));

      // Sanity test that makes sure tapping on each mood chip button changes the
      // selected mood via the callback to what is expected.
      for (final moodEntry in LIFELOG_MOOD_CHIP_KEYS.entries) {
        final finder = find.byKey(moodEntry.value);
        await tester.tap(finder);
        expect(currentMood, equals(moodEntry.key));
      }
    });
  });
}

Widget makeTestApp({@required Widget child}) {
  return MaterialApp(
    title: 'Positive Banking',
    home: Scaffold(body: child),
  );
}
