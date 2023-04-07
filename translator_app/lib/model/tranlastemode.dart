import 'package:dio/dio.dart';

class Translatemodel {
  var q;
  var detectlanguage;

  Translatemodel({required this.q, required this.detectlanguage});

  factory Translatemodel.fromjson(Map<String, dynamic> data) {
    return Translatemodel(
        q: data["data"]["translations"][0]["translatedText"],
        detectlanguage: data["data"]["translations"][0]
            ["detectedSourceLanguage"]);
  }
}
