// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper.dart';
import 'package:wallpaper_app/pages/second_page.dart';
import 'package:wallpaper_app/services/wallpaper_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WallpaperGrid extends StatefulWidget {
  const WallpaperGrid({Key? key}) : super(key: key);

  @override
  State<WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<WallpaperGrid> {
  late Future<List<Wallpaper>> _wallpaperGrid;
  Wallpaper wallpaper = Wallpaper();
  List<String> likedList = [];
  @override
  void initState() {
    super.initState();
    _wallpaperGrid = WallpaperApi.getWallpaperData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Wallpaper>>(
      future: _wallpaperGrid,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List listem = snapshot.data!;
          return GridView.builder(
            itemCount: listem.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    image(listem, index, context),
                    LikeButton(index, likedList: likedList, listem: listem),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          debugPrint('snapshot error');
          return const Text('internete bağlanın!');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  InkWell image(List<dynamic> listem, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        print(listem[index].url);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(
              url: listem[index].url,
            ),
          ),
        );
      },
      child: Hero(
        tag: listem[index].url,
        child: CachedNetworkImage(
          imageUrl: listem[index].url,
          fit: BoxFit.cover,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  const LikeButton(
    index, {
    Key? key,
    required this.likedList,
    required List listem,
  })  : _listem = listem,
        super(key: key);

  final List<String> likedList;
  final List _listem;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  var index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {
            widget.likedList.add(widget._listem[index].url);
            setState(() {});
            print(widget.likedList);
          },
        ),
      ),
    );
  }
}
