import 'dart:typed_data';

class DataPart {
  final String mimeType;
  final Uint8List bytes;

  DataPart(this.mimeType, this.bytes);
}
