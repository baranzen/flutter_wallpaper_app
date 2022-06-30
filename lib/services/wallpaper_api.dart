// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/wallpaper.dart';

class WallpaperApi {
  static var url = Uri.parse('https://baranben.com/wallpaper_api.json');
  static Future<List<Wallpaper>> getWallpaperData(query) async {
    var result = await http.get(url);
    if (result.statusCode == 200) {
      final List wallpapers = json.decode(result.body);
      return wallpapers
          .map((json) => Wallpaper.fromJson(json))
          .where((wallpapers) {
        final brandLower = wallpapers.brand?.toLowerCase();
        final searchLower = query.toLowerCase();
        return brandLower!.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
