import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';

class Body extends StatefulWidget {
  Body({Key? key, required this.progressString, required this.func2})
      : super(key: key);

  final Stream<String>? progressString;
  final Function func2;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var crossCount = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              onPressed: () {
                if (crossCount == 3) {
                  crossCount = 0;
                }
                setState(() {
                  crossCount++;
                });
              },
              icon: const Icon(
                Icons.view_comfy_rounded,
              )),
        ),
        Expanded(
          child: WallpaperGrid(crossCount, func: (likedList) {
            widget.func2(likedList);
          }),
        ),
      ],
    );
  }
}
