import 'package:hive/hive.dart';
part 'reserv_model.g.dart';

@HiveType(typeId: 2)
class ReservModel {
  @HiveField(0)
  String? tableName;
  @HiveField(1)
  String? tableNumber;
  @HiveField(2)
  String? reservDate;
  @HiveField(3)
  String? price;
  @HiveField(4)
  String? time;
  ReservModel(
      {this.tableName,
      this.tableNumber,
      this.reservDate,
      this.price,
      this.time});
}
