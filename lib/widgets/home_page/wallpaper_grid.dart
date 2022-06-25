// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, use_key_in_widget_constructors, must_be_immutable, must_call_super

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper.dart';
import 'package:wallpaper_app/pages/second_page.dart';
import 'package:wallpaper_app/services/wallpaper_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WallpaperGrid extends StatefulWidget {
  final Function func;
  WallpaperGrid(this.crossCount, {required this.func, Key? key})
      : super(key: key);
  var crossCount;
  @override
  State<WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<WallpaperGrid> {
  late Future<List<Wallpaper>> _wallpaperGrid;
  Wallpaper wallpaper = Wallpaper();

  @override
  void initState() {
    super.initState();
    _wallpaperGrid = WallpaperApi.getWallpaperData();
  }

  @override
  Widget build(BuildContext context) {
    print('listem $likedList');
    return FutureBuilder<List<Wallpaper>>(
      future: _wallpaperGrid,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List listem = snapshot.data!;
          return MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossCount,
            ),
            itemCount: listem.length,
            itemBuilder: (context, index) {
              return gridItem(listem, index, context);
            },
          );
        } else if (snapshot.hasError) {
          debugPrint('Error: ${snapshot.error}');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'internete bağlanın!',
                  style: TextStyle(fontSize: 24),
                ),
                TextButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Tekrar Deneyin'),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.teal,
            ),
          );
        }
      },
    );
  }

  List<String> likedList = [];

  Padding gridItem(List<dynamic> listem, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          image(listem, index, context),
          LikeButton(index, list: listem, addToLikedList: (url, sayac) {
            if (sayac % 2 == 1) {
              likedList.add(url);
            } else {
              likedList.remove(url);
            }
            print(likedList);
            widget.func(likedList);
          }),
        ],
      ),
    );
  }

  InkWell image(List<dynamic> listem, int index, BuildContext context) {
    return InkWell(
      onTap: () {
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: CachedNetworkImage(
            imageUrl: listem[index].url,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class LikeButton extends StatefulWidget {
  LikeButton(this.index,
      {Key? key, required this.list, required this.addToLikedList
      /*   required List listem,
  })  : _listem = listem, */
      });
  var index;
  List list;
  final List list2 = [];
  final Function addToLikedList;
  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late final List<String> likedList;
  var sayac;
  @override
  void initState() {
    likedList = [];
    sayac = 1;
    print('init');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: IconButton(
          icon: Icon(
            Icons.favorite,
            color: likeButtonColor(),
            shadows: const [
              Shadow(
                blurRadius: 10,
                color: Colors.white,
                offset: Offset(2, 2),
              ),
            ],
          ),
          onPressed: () {
            widget.addToLikedList(widget.list[widget.index].url, sayac);
            sayac++;
            setState(() {});
          },
        ),
      ),
    );
  }

  Color likeButtonColor() {
    if (sayac % 2 == 1) {
      return Colors.grey;
    } else {
      return Colors.red;
    }
  }
}
