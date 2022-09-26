// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, avoid_print, unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/model/wallpaper.dart';
import 'package:wallpaper_app/pages/second_page.dart';
import 'package:wallpaper_app/services/interstitialad.dart';
import 'package:wallpaper_app/widgets/home_page/grid_banner_ad.dart';
import 'package:wallpaper_app/widgets/home_page/snackbar.dart';
import 'package:wallpaper_app/widgets/second_page/bottom_sheet_widget.dart';

class WallpaperGrid extends StatefulWidget {
  WallpaperGrid(this.value, this.list, {Key? key, this.func}) : super(key: key);

  List<Wallpapers> list;
  var value;
  var func;
  @override
  State<WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<WallpaperGrid> {
  Stream<String>? progressString;
  late InterstitialAds _interstitialAds;
  late GridBannerAd gridBannerAd;
  late InterstitialAds interstitialAds;
  @override
  void initState() {
    interstitialAds = InterstitialAds();
    gridBannerAd = GridBannerAd();
    //! kapatıp açtığıda yeni foto ekleyince sıfırlanıyordu bu önemli
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  //! burada apiyi çağırmadım çünkü uzun sürecek onun hazır olup bu widget e listenin gelmesi gerekiyor.
  var adIndex = 1;
  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      );
    } else {
      return Expanded(
        child: MasonryGridView.builder(
          padding: const EdgeInsets.all(0),
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.value,
          ),
          itemCount: widget.list.length,
          itemBuilder: (context, index) {
            return itemBuilder(
              index,
              widget.list[index].src!.large2X,
            );
          },
        ),
      );
    }
  }

  List<String> likedList = [];

  Padding itemBuilder(int index, String? url) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              image(index),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.h),
                    topRight: Radius.circular(20.h),
                  ),
                ),
                height: 47.h,
                width: 29.h,
                child: dropwDown(url),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          if (index % 3 == 0) gridBannerAd
        ],
      ),
    );
  }

  dropwDown(url) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        showModalBottomSheet<void>(
          backgroundColor: Colors.white.withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          context: context,
          builder: (BuildContext context) {
            return BottomSheetWidget(
              progressString: progressString,
              url: url,
              adToLikedListFromLikedButton: (imageUrl) {
                sendToLikedList(imageUrl);
              },
            );
          },
        );
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
    );

    /* DropdownButton(
      onTap: () => interstitialAds.loadInterstitialAd(),
      borderRadius: BorderRadius.circular(8),
      underline: const SizedBox(),
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onChanged: (value) {
        sendToLikedList(url);
      },
      items: const [
        DropdownMenuItem(
          value: 1,
          child: Text('Like'),
        ),
      ],
    ); */
  }

  Widget image(int index) {
    return InkWell(
      onTap: () {
        interstitialAds.loadInterstitialAd();
        FocusScope.of(context).unfocus(); //! for close keyboard
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SecondPage(
              url: widget.list[index].src!.large2X,
              adToLikedListFromLikedButton: (imageUrl) {
                sendToLikedList(imageUrl);
              },
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.h),
        child: CachedNetworkImage(
          imageUrl: responsiveImage(widget.value, index),
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }

  responsiveImage(v, i) {
    switch (v) {
      case 1:
        return widget.list[i].src!.large ?? '';
      default:
        return widget.list[i].src!.large ?? '';
    }
  }

  void sendToLikedList(url) {
    if (likedList.contains(url)) {
      showSnackBarMessage(
        'You have already liked this wallpaper.',
        context,
        likedList: likedList,
      );
    } else {
      likedList.add(url);

      widget.func(likedList);
      showSnackBarMessage(
        'Added to liked list.',
        context,
        likedList: likedList,
      );
    }
  }
}
