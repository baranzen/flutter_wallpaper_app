import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/liked_page.dart';
import 'package:wallpaper_app/widgets/home_page/body.dart';
import 'package:wallpaper_app/widgets/home_page/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> likedList = [];

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
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  BottomNavigationBar bottomNavigationBar(context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          label: 'Liked',
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LikedPage(likedList),
            ),
          );
          showSnackBarMessage('To Delete, Slide to Left', context,
              action: false);
        }
      },
    );
  }
}
