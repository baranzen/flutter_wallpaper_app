import 'package:wallpaper_app/model/wallpaper.dart';

List<Wallpapers>? list;

writeToWallpaperList(List<Wallpapers> value) {
  list = value;
}

List<Wallpapers> getWallpaperList() => list!;
