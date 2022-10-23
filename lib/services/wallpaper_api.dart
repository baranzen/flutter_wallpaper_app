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
        'Authorization': '//YOUR API KEY//',
      },
    );

    List jsonList = jsonDecode(result.body)['photos'];
    list = jsonList.map((json) => Wallpapers.fromJson(json)).toList();
    return list;
  }
}
