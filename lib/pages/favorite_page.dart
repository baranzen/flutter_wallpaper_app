// ignore_for_file: must_be_immutable

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
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
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
        /*    setState(() {
          selectedItemIndex = index;
        }); */
      },
    );
  }
}
