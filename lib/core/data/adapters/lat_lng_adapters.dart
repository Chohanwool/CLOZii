import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

class LatLngAdapter extends TypeAdapter<LatLng> {
  @override
  final typeId = 2;

  @override
  LatLng read(BinaryReader reader) {
    return LatLng(reader.readDouble(), reader.readDouble());
  }

  @override
  void write(BinaryWriter writer, LatLng obj) {
    writer.writeDouble(obj.latitude);
    writer.writeDouble(obj.longitude);
  }
}
