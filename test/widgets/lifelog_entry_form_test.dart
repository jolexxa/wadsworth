import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wadsworth/blocs/blocs.dart';
import 'package:wadsworth/repos/repos.dart';
import 'package:wadsworth/widgets/widgets.dart';

import '../shared/mock_lifelog_repo.dart';

void main() {
  group('LifelogEntryForm', () {
    LifelogRepo repo;
    LifelogBloc lifelogBloc;

    setUp(() {
      repo = MockLifelogRepository();
      lifelogBloc = LifelogBloc(repo: repo);
    });

    testWidgets('instantiates correctly', (tester) async {
      await tester.pumpWidget(makeTestApp(
        lifelogBloc: lifelogBloc,
        child: LifelogEntryForm(),
      ));
    });
  });
}

Widget makeTestApp({
  @required LifelogBloc lifelogBloc,
  @required Widget child,
}) {
  return BlocProvider<LifelogBloc>(
    create: (BuildContext context) => lifelogBloc,
    child: MaterialApp(
      title: 'Positive Banking',
      home: Scaffold(body: child),
    ),
  );
}
