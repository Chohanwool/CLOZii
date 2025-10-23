// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TradeTypeAdapter extends TypeAdapter<TradeType> {
  @override
  final int typeId = 4;

  @override
  TradeType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TradeType.sell;
      case 1:
        return TradeType.share;
      default:
        return TradeType.sell;
    }
  }

  @override
  void write(BinaryWriter writer, TradeType obj) {
    switch (obj) {
      case TradeType.sell:
        writer.writeByte(0);
        break;
      case TradeType.share:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TradeTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
