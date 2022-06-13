// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:wallpaper/wallpaper.dart';

Future<void> setWallPaper(progressString, context, url) async {
  progressString = Wallpaper.imageDownloadProgress(url);

  progressString!.listen(
    (data) {
      print("Downloading: " + data);
    },
    onDone: () async {
      print("Task Done");
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      await Wallpaper.homeScreen(
          options: RequestSizeOptions.RESIZE_FIT, width: width, height: height);
    },
    onError: (error) {
      print("Some Error");
    },
  );
}
