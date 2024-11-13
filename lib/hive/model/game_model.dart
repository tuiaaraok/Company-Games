import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
part 'game_model.g.dart';

@HiveType(typeId: 1)
class GameModel {
  @HiveField(0)
  Uint8List? imageGame;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? rules;
  GameModel({this.imageGame, this.description, this.rules});
}
