// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_create_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostCreateStateAdapter extends TypeAdapter<PostCreateState> {
  @override
  final int typeId = 3;

  @override
  PostCreateState read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PostCreateState(
      title: fields[0] as String,
      content: fields[1] as String,
      tradeType: fields[2] as TradeType,
      price: fields[3] as int,
      meetingLocation: fields[4] as MeetingLocation?,
      selectedImages: (fields[5] as Map).cast<String, ImageData>(),
    );
  }

  @override
  void write(BinaryWriter writer, PostCreateState obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.tradeType)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.meetingLocation)
      ..writeByte(5)
      ..write(obj.selectedImages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostCreateStateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
