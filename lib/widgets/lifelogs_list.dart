import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wadsworth/blocs/blocs.dart';
import 'package:wadsworth/widgets/widgets.dart';

class LifelogsList extends StatefulWidget {
  @override
  _LifelogsListState createState() => _LifelogsListState();
}

class _LifelogsListState extends State<LifelogsList> {
  final ScrollController _scrollController = ScrollController();

  Completer<void> _refreshCompleter = Completer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lifelogBloc = BlocProvider.of<LifelogBloc>(context);
    return BlocBuilder<LifelogBloc, LifelogState>(
      builder: (context, state) {
        if (state is LifelogStateLoadSuccess) {
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          if (state.lifelogs.isNotEmpty) {
            // Empty space so we can over-scroll a bit so that floating
            // action button doesn't obscure stuff
            final listViewChildren = <Widget>[
              ...List.generate(
                state.lifelogs.length,
                (int index) {
                  final lifelog = state.lifelogs[index];
                  return LifelogEntrySummary(
                    lifelog: lifelog,
                    key: Key(lifelog.id.toString()),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 32),
              ),
            ];
            return RefreshIndicator(
              onRefresh: () {
                lifelogBloc.add(LifelogReloadRequested());
                return _refreshCompleter.future;
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                children: listViewChildren,
              ),
            );
          } else {
            // Successfully loaded, but no items
            return Padding(
              padding: EdgeInsets.only(bottom: 90),
              child: EmptyArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Icon(
                            Icons.lightbulb_outline,
                            size: 70,
                            color: theme.primaryTextTheme.headline6.color
                                .withAlpha(128),
                          ),
                        ),
                        Text(
                          'Add your first memory!',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6.copyWith(
                            fontWeight: FontWeight.w200,
                            color: theme.primaryTextTheme.headline6.color
                                .withAlpha(128),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          // Loading Indicator
          return EmptyArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 64),
              child: SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
