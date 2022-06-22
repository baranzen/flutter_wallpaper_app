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
  TabController? tabController;
/*   //! keys

  var keyFavoritePage = PageStorageKey('favoritePage');
  //! pages
  late List<Widget> myPages;
  late Body page0;
  late FavoritePage page1; */

  int selectedItemIndex = 0;
  List<String> likedList = [];
/*   @override
  void initState() {
    page0 = Body(
      progressString: progressString,
      key: keyBodyPage,
      func2: (likedList) {
        setState(() {
          likedList2 = likedList;
        });
      },
    );
    page1 = FavoritePage(key: keyFavoritePage, likedList: likedList2);
    myPages = [page0, page1];

    super.initState();
  } */
  var keyBodyPage = const PageStorageKey('bodyPage');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Body(
        progressString: progressString,
        key: keyBodyPage,
        func2: (likedList) {
          setState(() {
            this.likedList = likedList;
          });
/*           print('selam $url'); */
        },
      ),
      /* Body(progressString: progressString), */
      bottomNavigationBar: bottomNavigationBar(),
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
        switch (index) {
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoritePage(likedList)));
            break;
        }
        /*    setState(() {
          selectedItemIndex = index;
        }); */
      },
    );
  }
}
