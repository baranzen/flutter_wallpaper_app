// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage(this.likedList, {Key? key}) : super(key: key);
  List<String> likedList;

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: MasonryGridView.builder(
        itemCount: widget.likedList.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                image(index),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.likedList.remove(widget.likedList[index]);
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  ClipRRect image(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.0),
      child: CachedNetworkImage(
        imageUrl: widget.likedList[index],
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
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: const Text(
        'Wallpaper App',
        style: TextStyle(
          color: Colors.teal,
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar(context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Anasayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          label: 'Favoriler',
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          //!push yapınca ltekrar gelince listeler gözükmüyor
          //!pop yap ki listeler tekrardan gözüksün
          Navigator.pop(context);
        }
      },
    );
  }
}
