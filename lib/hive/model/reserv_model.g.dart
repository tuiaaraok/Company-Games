// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserv_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReservModelAdapter extends TypeAdapter<ReservModel> {
  @override
  final int typeId = 2;

  @override
  ReservModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReservModel(
      tableName: fields[0] as String?,
      tableNumber: fields[1] as String?,
      reservDate: fields[2] as String?,
      price: fields[3] as String?,
      time: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReservModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tableName)
      ..writeByte(1)
      ..write(obj.tableNumber)
      ..writeByte(2)
      ..write(obj.reservDate)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
