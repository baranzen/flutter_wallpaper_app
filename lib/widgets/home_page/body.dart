import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';

class Body extends StatelessWidget {
  const Body({Key? key, required this.progressString, required this.func2})
      : super(key: key);

  final Stream<String>? progressString;
  final Function func2;
  @override
  Widget build(BuildContext context) {
    return WallpaperGrid(func: (likedList) {
      func2(likedList);
    });

    /* Center(
      child: TextButton(
        child: const Text(
          'wallpaper',
          style: TextStyle(fontSize: 65),
        ),
        onPressed: () async {
          await setWallPaper(progressString, context);
        },
      ),
    ); */
  }
}
