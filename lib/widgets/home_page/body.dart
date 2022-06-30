import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper.dart';
import 'package:wallpaper_app/widgets/home_page/search_bar.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';
import '../../services/wallpaper_api.dart';

class Body extends StatefulWidget {
  var func2;
  Body({Key? key, this.func2}) : super(key: key);

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  List<Wallpaper> wallpapers = [];
  String query = '';
  Timer? debouncer;
  var value = 2;
  var cross = 2;
  @override
  void initState() {
    super.initState();

    init();
  }

  Future init() async {
    final wallpapers = await WallpaperApi.getWallpaperData(query);

    setState(() => this.wallpapers = wallpapers);
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            top(context),
            WallpaperGrid(
              cross,
              wallpapers,
              context,
              func: (likedList) {
                widget.func2(likedList);
              },
            )
          ],
        ),
      );
  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 10),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  SafeArea top(BuildContext context) {
    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: [
          const WallpaperAppText(),
          dropDown(),
          buildSearch(),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchBar(
        text: query,
        hintText: 'marka, model veya link',
        onChanged: searchWallpaper,
      );

  Future searchWallpaper(String query) async => debounce(() async {
        final wallpapers = await WallpaperApi.getWallpaperData(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.wallpapers = wallpapers;
        });
      });

  Align dropDown() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: DropdownButton(
          focusColor: Colors.teal,
          iconEnabledColor: Colors.teal,
          onChanged: (value2) {
            setState(() {
              value = value2 as int;
              cross = value;
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
    );
  }
}

class WallpaperAppText extends StatelessWidget {
  const WallpaperAppText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Wallpaper App',
      style: TextStyle(color: Colors.teal, fontSize: 17),
    );
  }
}
