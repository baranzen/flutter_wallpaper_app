// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  FavoritePage(this.likedList, {Key? key}) : super(key: key);
  List<String> likedList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GridView.builder(
        itemCount: likedList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              likedList[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
      bottomNavigationBar: bottomNavigationBar(context),
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
