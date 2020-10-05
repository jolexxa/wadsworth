import 'package:lifelog_repo/src/clients/clients.dart';
import 'package:meta/meta.dart';
import 'package:wadsworth/models/models.dart';

class LifelogRepo {
  LifelogRepo({@required LifelogClient client}) : _client = client;

  final LifelogClient _client;

  Future<void> addLifelog(Lifelog lifelog) async {
    await _client.insert(lifelog.toEntity());
  }

  Future<void> deleteLifelog(Lifelog lifelog) async {
    await _client.delete(lifelog.dbId);
  }

  Future<List<Lifelog>> getAllLifelogs() async {
    return (await _client.all())
        .map((lifelogEntity) => Lifelog.fromEntity(lifelogEntity))
        .toList();
  }
}
