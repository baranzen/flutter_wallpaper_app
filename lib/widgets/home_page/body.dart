import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.progressString,
  }) : super(key: key);

  final Stream<String>? progressString;

  @override
  Widget build(BuildContext context) {
    return const WallpaperGrid();

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
