// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:wallpaper_app/widgets/home_page/snackbar.dart';

Future<void> setWallPaper(progressString, context, url, index) async {
  progressString = Wallpaper.imageDownloadProgress(url);

  progressString!.listen(
    (data) {},
    onDone: () async {
      Navigator.of(context).pop();
      showSnackBarMessage(
        'Image Setted as Wallpaper',
        context,
        action: false,
      );

      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;

      switch (index) {
        case 1:
          await Wallpaper.homeScreen(
            options: RequestSizeOptions.RESIZE_EXACT,
            width: width,
            height: height,
          );
          break;
        case 2:
          await Wallpaper.lockScreen(
            options: RequestSizeOptions.RESIZE_EXACT,
            width: width,
            height: height,
          );
          break;
        case 3:
          await Wallpaper.bothScreen(
            options: RequestSizeOptions.RESIZE_EXACT,
            width: width,
            height: height,
          );
          break;
      }
    },
    onError: (error) {
      print("Some Error");
    },
  );
}
