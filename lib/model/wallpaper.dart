// To parse this JSON data, do
//
//     final wallpaper = wallpaperFromJson(jsonString);

import 'dart:convert';

List<Wallpaper> wallpaperFromJson(String str) =>
    List<Wallpaper>.from(json.decode(str).map((x) => Wallpaper.fromJson(x)));

String wallpaperToJson(List<Wallpaper> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wallpaper {
  String? url;
  String? brand;
  Wallpaper({
    this.url,
    this.brand,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
        url: json["url"] == null ? null : json["url"],
        brand: json["brand"] == null ? null : json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "brand": brand == null ? null : brand,
      };
}
