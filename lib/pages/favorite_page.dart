import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  FavoritePage(this.likedList, {Key? key}) : super(key: key);
  List<String> likedList;
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      body: GridView.builder(
        itemCount: widget.likedList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              widget.likedList[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
