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
        'X-RapidAPI-Key': '0107807461msh79cfdc01a4b2541p133003jsnde45ea39999c',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      },
    ),
  );
  //print(res.data);
  Translatemodel model = Translatemodel.fromjson(res.data);

  return model;
}
