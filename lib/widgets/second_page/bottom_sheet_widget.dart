import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/services/set_wallpaper.dart';
import 'package:wallpaper_app/widgets/second_page/like_button.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    Key? key,
    required this.progressString,
    required this.url,
    this.adToLikedListFromLikedButton,
  }) : super(key: key);

  final Stream<String>? progressString;
  final url;
  final adToLikedListFromLikedButton;

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var isSetWallpaperClicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 0),
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: SafeArea(
          child: isSetWallpaperClicked
              ? setWallpaperTrue()
              : setWallpaperFalse(context),
        ),
      ),
    );
  }

  setWallpaperTrue() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isSetWallpaperClicked = false;
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: TextButton(
                child: SizedBox(
                  width: 50.w,
                  child: const Divider(
                    thickness: 2,
                    color: Colors.black,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
        whichScreenWallpaperButton('Home Screen', 1),
        SizedBox(
          height: 20.h,
        ),
        whichScreenWallpaperButton('Lock Screen', 2),
        SizedBox(
          height: 20.h,
        ),
        whichScreenWallpaperButton('Both', 3),
      ],
    );
  }

  Container whichScreenWallpaperButton(text, index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.teal.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          setWallPaper(widget.progressString, context, widget.url, index);
          setState(() {
            isSetWallpaperClicked = true;
          });
        },
      ),
    );
  }

  Column setWallpaperFalse(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: TextButton(
                child: SizedBox(
                  width: 50.w,
                  child: Divider(
                    thickness: 2,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
              /* IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.straight),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ), */
              ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.teal.withOpacity(0.7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              child: const Text(
                'Set Wallpaper',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                setState(() {
                  isSetWallpaperClicked = true;
                });
              },
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              /* for (var i = 0; i < 2; i++) const LikeButton(), */
              LikeButton(
                url: widget.url,
                index: 0,
                caption: 'Like',
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                adToLikedListFromLikedButton: (imageUrl) {
                  widget.adToLikedListFromLikedButton(imageUrl);
                },
              ),
              SizedBox(width: 15.w),
              const LikeButton(
                index: 1,
                caption: 'Share',
                icon: Icon(
                  Icons.share,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              /* for (var i = 0; i < 2; i++) const LikeButton(), */
              LikeButton(
                index: 2,
                caption: 'Download',
                icon: const Icon(Icons.download),
                url: widget.url,
              ),
              SizedBox(width: 15.w),
              LikeButton(
                index: 3,
                caption: 'See On Website',
                icon: const Icon(Icons.web),
                url: widget.url,
              ),
            ],
          ),
          /*   Container(
              width: MediaQuery.of(context).size.width,
              child: ListTile(
                leading: CachedNetworkImage(imageUrl: url),
                trailing: Text('asd2'),
                title: Text('asd3'),
                subtitle: Text('asd4'),
              ),
            ), */
        ],
      );
}
