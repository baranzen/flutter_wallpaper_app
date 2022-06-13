import 'dart:convert';

List<Wallpaper> wallpaperFromJson(String str) =>
    List<Wallpaper>.from(json.decode(str).map((x) => Wallpaper.fromJson(x)));

String wallpaperToJson(List<Wallpaper> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wallpaper {
  Wallpaper({
    this.url,
  });

  String? url;

  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
      };
  @override
  String toString() {
    return '$url';
  }
}
