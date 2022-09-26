// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/widgets/home_page/snackbar.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key,
    this.icon,
    this.caption,
    this.index,
    this.adToLikedListFromLikedButton,
    this.url,
  }) : super(key: key);
  final icon;
  final caption;
  final index;
  final url;
  final adToLikedListFromLikedButton;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: 3.w),
              Text(
                caption,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
          onPressed: () {
            switch (index) {
              case 0:
                Navigator.pop(context);
                adToLikedListFromLikedButton(url);

                break;
              case 1:
                break;
              case 2:
                ImageDownloader.downloadImage(url).then((value) {
                  Navigator.pop(context);
                  showSnackBarMessage(
                    'Image Downloaded',
                    context,
                    action: false,
                  );
                });
                break;
              case 3:
                _launchUrl(url);
                break;
            }
          },
        ),
      ),
    );
  }

  Future<void> _launchUrl(_url) async {
    var url = Uri.parse(_url);
    try {
      await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {
      print('catched error is $e');
    }
  }
}
