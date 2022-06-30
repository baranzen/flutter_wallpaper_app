import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/model/wallpaper.dart';
import 'package:wallpaper_app/widgets/home_page/like_button.dart';
import '../../pages/second_page.dart';

class WallpaperGrid extends StatefulWidget {
  //!! stateless yapınca liste tek elaman oluor statefull yaptım ama setsate yok
  WallpaperGrid(this.cross, this.wallpapers, this.context,
      {Key? key, this.func})
      : super(key: key);
  var cross;
  var wallpapers;
  var context;
  var func;

  @override
  State<WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<WallpaperGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MasonryGridView.builder(
        padding: const EdgeInsets.all(0),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.cross,
        ),
        itemCount: widget.wallpapers.length,
        itemBuilder: (context, index) {
          final wallpaper = widget.wallpapers[index];
          return buildWallpaper(wallpaper, index);
        },
      ),
    );
  }

  List<String> likedList = [];

  Widget buildWallpaper(Wallpaper wallpaper, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            image(wallpaper),
            LikeButton(index, list: widget.wallpapers,
                addToLikedList: (url, sayac) {
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

  InkWell image(Wallpaper wallpaper) {
    return InkWell(
      onTap: () {
        Navigator.push(
          widget.context,
          MaterialPageRoute(
            builder: (context) => SecondPage(
              url: wallpaper.url,
            ),
          ),
        );
      },
      child: Hero(
        tag: wallpaper.url!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: CachedNetworkImage(
            imageUrl: wallpaper.url!,
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
