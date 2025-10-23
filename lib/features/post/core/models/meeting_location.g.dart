// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeetingLocationAdapter extends TypeAdapter<MeetingLocation> {
  @override
  final int typeId = 1;

  @override
  MeetingLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeetingLocation(
      coordinate: fields[0] as LatLng,
      detailAddress: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MeetingLocation obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.coordinate)
      ..writeByte(1)
      ..write(obj.detailAddress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetingLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
