import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:translator_app/model/tranlastemode.dart';

Future<Translatemodel> translate(String q, String target) async {
  var match = {"q": q, "target": target};
  Dio dio = new Dio();
  var res = await dio.post(
    'https://google-translate1.p.rapidapi.com/language/translate/v2',
    data: match,
    options: new Options(
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
        'Accept-Encoding': 'application/gzip',
        'X-RapidAPI-Key': 'a0f5e6e9eamsh4d80afa33d60788p1f06fejsn7be51220d2eb',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      },
    ),
  );
  //print(res.data);
  Translatemodel model = Translatemodel.fromjson(res.data);

  return model;
}

Future<List<dynamic>> fetchlanguages() async {
  Dio dio = new Dio();
  var res = await dio.get(
    'https://google-translate1.p.rapidapi.com/language/translate/v2/languages',
    options: new Options(
      headers: {
        'content-type': 'application/x-www-form-urlencoded',
        'Accept-Encoding': 'application/gzip',
        'X-RapidAPI-Key': 'a0f5e6e9eamsh4d80afa33d60788p1f06fejsn7be51220d2eb',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      },
    ),
  );
  //print(res.data);
  List<dynamic> languages = res.data['data']['languages'];
  //print(languages[0]['language']);
  return languages;
}
