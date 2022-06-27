import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.progressString, required this.func2})
      : super(key: key);

  final Stream<String>? progressString;
  final Function func2;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var crossCount = 2;
  var value = 2;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: DropdownButton(
              onChanged: (value2) {
                setState(() {
                  value = value2 as int;
                  crossCount = value2;
                });
              },
              value: value,
              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Icon(
                    Icons.view_agenda,
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Icon(Icons.view_cozy_outlined),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Icon(Icons.view_column),
                ),
              ],
            ),
          ),
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
