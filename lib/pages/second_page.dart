// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/set_wallpaper.dart';

// ignore: must_be_immutable
class SecondPage extends StatelessWidget {
  SecondPage({required this.url, Key? key}) : super(key: key);

  var url;
  Stream<String>? progressString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(url: url, progressString: progressString),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.url,
    required this.progressString,
  }) : super(key: key);

  final url;
  final Stream<String>? progressString;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Hero(
            tag: url,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const BackArrow(),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'duvarkağıdı ayarla',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              onPressed: () {
                /*  setWallPaper(progressString, context, url); */
                _showActionSheet(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Duvar kadığını hangi ekrana ayarlamak istersin'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              setWallPaper(progressString, context, url);
            },
            child: const Text('Ana Ekran'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Kilit Ekranı'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Her ikisi'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Kapat'),
          )
        ],
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
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
    );
  }
}
