import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wadsworth/blocs/blocs.dart';
import 'package:wadsworth/models/lifelog.dart';
import 'package:wadsworth/repos/repos.dart';

import '../shared/mock_lifelog_repo.dart';

void main() {
  group('LifelogBloc', () {
    LifelogRepo repo;

    final fakeLifelogs = <Lifelog>[
      Lifelog(mood: Mood.Meh, thoughts: 'Thought 1'),
      Lifelog(mood: Mood.Bad, thoughts: 'Thought 2'),
      Lifelog(mood: Mood.Good, thoughts: 'Thought 3')
    ];

    setUp(() {
      repo = MockLifelogRepository();
    });

    blocTest(
      'Handles loading success',
      build: () {
        when(repo.getAllLifelogs())
            .thenAnswer((_) => Future.value(fakeLifelogs));
        return LifelogBloc(repo: repo);
      },
      act: (LifelogBloc bloc) {
        bloc..add(LifelogReloadRequested());
      },
      expect: <LifelogState>[
        LifelogStateLoadSuccess(lifelogs: fakeLifelogs),
      ],
    );

    blocTest(
      'Handles loading failure',
      build: () {
        when(repo.getAllLifelogs())
            .thenThrow(Exception('Lifelog repo load failure'));
        return LifelogBloc(repo: repo);
      },
      act: (LifelogBloc bloc) {
        bloc..add(LifelogReloadRequested());
      },
      expect: <LifelogState>[LifelogStateLoadFailure()],
    );
  });
}
