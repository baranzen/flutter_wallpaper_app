// ignore_for_file: prefer_typing_uninitialized_variables, unused_element

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/services/set_wallpaper.dart';
import 'package:wallpaper_app/widgets/second_page/bottom_sheet_widget.dart';

// ignore: must_be_immutable
class SecondPage extends StatefulWidget {
  SecondPage({required this.url, Key? key, this.adToLikedListFromLikedButton})
      : super(key: key);
  final adToLikedListFromLikedButton;
  var url;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Stream<String>? progressString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        url: widget.url,
        progressString: progressString,
        adToLikedListFromLikedButton: (imageUrl) {
          widget.adToLikedListFromLikedButton(imageUrl);
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.url,
    required this.progressString,
    this.adToLikedListFromLikedButton,
  }) : super(key: key);
  final adToLikedListFromLikedButton;
  final url;
  final Stream<String>? progressString;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(url: url),
        const BackArrow(),
        button(context),
      ],
    );
  }

  Padding button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(218, 41, 214, 162).withOpacity(0.5),
            ),
            shadowColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(218, 230, 230, 230).withOpacity(0.5),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(9.0.w),
            child: const Text(
              'Set Wallpaper',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          onPressed: () {
            bottomSheet(context);
            /* _showActionSheet(context); */
          },
        ),
      ),
    );
  }

  Future<void> bottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWidget(
          progressString: progressString,
          url: url,
          adToLikedListFromLikedButton: adToLikedListFromLikedButton,
        );
      },
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Which screen would you like to set as wallpaper?'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              setWallPaper(progressString, context, url, 1);
            },
            child: const Text('Home Screen'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setWallPaper(progressString, context, url, 2);
            },
            child: const Text('Lock Screen'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              setWallPaper(progressString, context, url, 3);
            },
            child: const Text('Both'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          )
        ],
      ),
    );
  }
}

class Image extends StatelessWidget {
  const Image({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 31.h,
              shadows: [
                BoxShadow(
                  color: Colors.teal.withOpacity(1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
                BoxShadow(
                  color: Colors.teal.withOpacity(1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
