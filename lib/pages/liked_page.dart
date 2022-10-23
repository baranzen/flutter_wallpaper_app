// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/pages/home_page.dart';

import 'second_page.dart';

class LikedPage extends StatefulWidget {
  LikedPage(this.likedList, {Key? key}) : super(key: key);
  List<String> likedList;

//! for ads

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  late Set sett;

  @override
  Widget build(BuildContext context) {
    sett = widget.likedList.toSet();

    return Scaffold(
      appBar: appBar(),
      body: body(),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }

  body() {
    return widget.likedList.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'There is no liked wallpaper!',
                  style: TextStyle(fontSize: 16.sp),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Tap to Home',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              ],
            ),
          )
        : MasonryGridView.builder(
            itemCount: widget.likedList.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    image(index),
                  ],
                ),
              );
            },
          );
  }

  InkWell image(int index) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus(); //! for close keyboard
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SecondPage(
              url: sett.elementAt(index),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Dismissible(
          key: ValueKey(sett.elementAt(index)),
          onDismissed: (direction) {
            setState(() {
              widget.likedList.removeAt(index);
            });
          },
          child: CachedNetworkImage(
            imageUrl: sett.elementAt(index),
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        'wallpaper app',
        style: GoogleFonts.chewy(
          color: Colors.teal,
          fontSize: 38.sp,
        ),
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar(context) {
    return BottomNavigationBar(
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
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
        if (index == 0) {
          //!push yapınca ltekrar gelince listeler gözükmüyor
          //!pop yap ki listeler tekrardan gözüksün
          navigate();
        }
      },
    );
  }

  navigate() async {
    var boo = await Navigator.maybePop(context);
    if (!boo) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }

    print(boo);
  }
}
