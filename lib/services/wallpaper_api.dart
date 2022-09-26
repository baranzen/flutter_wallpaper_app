// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper.dart';

class WallpaperApi {
  static Future<List<Wallpapers>> getApi() async {
    List<Wallpapers> list = [];

    var result = await http.get(
      Uri.parse(
          "https://api.pexels.com/v1/curated?per_page=80&orientation=portrait"),
      headers: {
        'Authorization':
            '563492ad6f91700001000001c7c269d3ea8143c8b04c6202c1c29ef9',
      },
    );

    List jsonList = jsonDecode(result.body)['photos'];
    list = jsonList.map((json) => Wallpapers.fromJson(json)).toList();
    return list;
  }
}
