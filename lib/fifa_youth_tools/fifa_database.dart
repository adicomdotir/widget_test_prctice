import 'package:hive/hive.dart';
import 'package:widget_test_practice/fifa_youth_tools/config/constants.dart';
import 'package:widget_test_practice/fifa_youth_tools/player_model.dart';

class FifaDatabase {
  static FifaDatabase? _instance;

  FifaDatabase._();

  static FifaDatabase getInstance() {
    _instance ??= FifaDatabase._();
    return _instance!;
  }

  List<PlayerModel> fetchPlayers() {
    final playersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    return playersBox.values.toList();
  }

  Future<void> addPlayer(PlayerModel playerModel) {
    final playersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    if (playerModel.id == 0) {
      int id = playersBox.values.length + 1;
      final newPlayerModel = playerModel.copyWith(id: id);
      return playersBox.put(id, newPlayerModel);
    }
    return playersBox.put(playerModel.id, playerModel);
  }

  PlayerModel? fetchPlayerWithId(int playerId) {
    final playersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    return playersBox.get(playerId);
  }

  void deletePlayer(int playerId) {
    final playersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    playersBox.delete(playerId);
  }
}
