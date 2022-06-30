// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/favorite_page.dart';
import '../widgets/home_page/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //! wallpaper veriables
  Stream<String>? progressString;

  int selectedItemIndex = 0;
  List<String> likedList = [];
  var textController = TextEditingController();
  var keyBodyPage = const PageStorageKey('bodyPage');
  var crossCount = 2;
  var value = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        func2: (likedList) {
          setState(() {
            this.likedList = likedList;
          });
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
          backgroundColor: Colors.green,
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
        switch (index) {
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoritePage(likedList)));
            break;
        }
      },
    );
  }
}
