import 'dart:convert';

class EncryptService {
  static final EncryptService _instance = EncryptService._internal();

  factory EncryptService() {
    return _instance;
  }

  EncryptService._internal();

  String encode(String text) {
    return base64Encode(utf8.encode(text));
  }

  String decode(String text) {
    return utf8.decode(base64Decode(text));
  }

  bool match(String textOriginal, String textEncode) {
    String textDecode = decode(textEncode);
    return textOriginal == textDecode;
  }
}
