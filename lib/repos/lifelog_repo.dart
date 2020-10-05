import 'package:lifelog_repo/src/clients/clients.dart';
import 'package:meta/meta.dart';
import 'package:wadsworth/models/models.dart';

class LifelogRepo {
  LifelogRepo({@required this.client});

  final LifelogClient client;

  Future<void> addLifelog(Lifelog lifelog) async {
    await client.insert(lifelog.toEntity());
  }

  Future<void> deleteLifelog(Lifelog lifelog) async {
    await client.delete(lifelog.dbId);
  }

  Future<List<Lifelog>> getAllLifelogs() async {
    return (await client.all())
        .map((lifelogEntity) => Lifelog.fromEntity(lifelogEntity))
        .toList();
  }
}
