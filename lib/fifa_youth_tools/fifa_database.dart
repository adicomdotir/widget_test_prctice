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
    final customersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    return customersBox.values.toList();
  }

  Future<void> addPlayer(PlayerModel playerModel) {
    final customersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    if (playerModel.id == '0') {
      int id = customersBox.values.length + 1;
      final newPlayerModel = playerModel.copyWith(id: id.toString());
      return customersBox.put(id, newPlayerModel);
    }
    return customersBox.put(playerModel.id, playerModel);
  }

  PlayerModel? fetchPlayerWithId(String playerId) {
    final customersBox = Hive.box<PlayerModel>(Constants.playerTableName);
    return customersBox.get(playerId);
  }
}
