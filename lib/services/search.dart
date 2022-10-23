// ignore_for_file: avoid_print

import 'dart:convert';
import '../../model/wallpaper.dart';
import 'package:http/http.dart' as http;

Future<List<Wallpapers>> getSearchApi(value) async {
  List<Wallpapers> searchList = [];

  var result = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/search?query=$value&per_page=80&orientation=portrait"),
      headers: {
        'Authorization':
            '563492ad6f91700001000001c7c269d3ea8143c8b04c6202c1c29ef9',
      });

  if (result.statusCode == 200) {
    List jsonList = jsonDecode(result.body)['photos'];
    /*  print(result.body); */
    searchList = jsonList.map((json) => Wallpapers.fromJson(json)).toList();
    return searchList;
  } else {
    throw Exception('failed to load data!');
  }
}
