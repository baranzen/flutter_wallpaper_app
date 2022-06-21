// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper.dart';

class WallpaperApi {
  static var url = Uri.parse('https://baranben.com/wallpaper_api.json');
  static Future<List<Wallpaper>> getWallpaperData() async {
    List<Wallpaper> list = [];
    var result = await http.get(url);

    var wallList = jsonDecode(result.body);
/*     debugPrint(wallList.toString()); */

    if (wallList is List) {
      list = wallList.map((e) => Wallpaper.fromJson(e)).toList();
    } else {
      return [];
    }
    return list;
  }
}
