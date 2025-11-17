// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageDataAdapter extends TypeAdapter<ImageData> {
  @override
  final int typeId = 0;

  @override
  ImageData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageData(
      originBytes: fields[0] as Uint8List?,
      thumbnailBytes: fields[1] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.originBytes)
      ..writeByte(1)
      ..write(obj.thumbnailBytes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
