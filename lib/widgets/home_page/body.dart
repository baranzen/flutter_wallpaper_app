// ignore_for_file: avoid_print, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/services/banner_ad.dart';
import 'package:wallpaper_app/services/interstitialad.dart';
import 'package:wallpaper_app/services/search.dart';
import 'package:wallpaper_app/services/wallpaper_api.dart';
import 'package:wallpaper_app/widgets/home_page/search_bar.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_app_text.dart';
import 'package:wallpaper_app/widgets/home_page/wallpaper_grid.dart';
import '../../model/wallpaper.dart';

class Body extends StatefulWidget {
  Body({Key? key, this.func2}) : super(key: key);
  var func2;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
//
  late InterstitialAds interstitialAd;

  late BannerAds headerBanner;
  late BannerAds footerBanner;
  @override
  void initState() {
    interstitialAd = InterstitialAds();
    headerBanner = BannerAds();
    //! *  interstitialAd.loadInterstitialAd(); */
    footerBanner = BannerAds();
    getApi();
    footerBanner.looadStaticBannerAd('ca-app-pub-1426970669505408/7657826411');
    headerBanner.looadStaticBannerAd('ca-app-pub-1426970669505408/7287835919');
    super.initState();
  }

  Future getApi() async {
    List<Wallpapers> wallpapers = await WallpaperApi.getApi();
    setState(() => wallpapersList = wallpapers);
  }

  var value2 = '';
  var value = 2;

  List<Wallpapers> wallpapersList = [];
  List<Wallpapers> searchList = [];

  var chip1 = 'Car';
  var chip2 = 'Nature';
  var chip3 = 'Space';
  var chip4 = 'Animals';
  var chip5 = 'Anime';
  var chip6 = 'Food';
  var chip7 = 'Sports';
  var carClicked = false;

  // ! for ads

  @override
  build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        top(context),
        /*    headerBanner.bannerWidget(), */
        chipWidget(),
        if (value2 != '')
          WallpaperGrid(
            value,
            searchList,
            func: (likedList) {
              widget.func2(likedList);
            },
          )
        else
          WallpaperGrid(
            value,
            wallpapersList,
            func: (likedList) {
              widget.func2(likedList);
            },
          ),
        footerBanner.bannerWidget(),
      ],
    );
  }

  Widget chipWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8),
      child: SizedBox(
        height: 43.h,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            trendsChip(),
            carClicked
                ? InkWell(
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        chip1 = 'Car';
                        chip2 = 'Nature';
                        chip3 = 'Space';
                        chip4 = 'Animals';
                        chip5 = 'Anime';
                        chip6 = 'Food';
                        chip7 = 'Sports';
                        carClicked = false;
                        value2 = '';
                      });
                    },
                  )
                : Container(),
            chips(
              wallpapersList,
              chip1,
              carCheck: false,
              padd: carClicked ? 0.0 : 8.0,
            ),
            chips(
              wallpapersList,
              chip2,
              carCheck: true,
            ),
            chips(
              wallpapersList,
              chip3,
              carCheck: true,
            ),
            chips(
              wallpapersList,
              chip4,
              carCheck: true,
            ),
            chips(
              wallpapersList,
              chip5,
              carCheck: true,
            ),
            chips(
              wallpapersList,
              chip6,
              carCheck: true,
            ),
            chips(
              wallpapersList,
              chip7,
              carCheck: true,
            ),
          ],
        ),
      ),
    );
  }

  Padding trendsChip() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 5,
      ),
      child: InkWell(
        onTap: () async {
          interstitialAd.loadInterstitialAd();
          if (carClicked) {
            //! üste alınca çalıştı
            setState(() {
              carClicked = false;
              chip1 = 'Car';
              chip2 = 'Nature';
              chip3 = 'Space';
            });
          }
          setState(() {
            value2 = '';
            getApi();
          });
        },
        child: Chip(
          backgroundColor: Colors.grey.shade300.withOpacity(0.5),
          label: Text(
            'Trends',
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }

  chips(List<Wallpapers> list, String categorie, {carCheck, padd = 8.0}) {
    return Padding(
      padding: EdgeInsets.only(left: padd, right: 8, bottom: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        child: InkWell(
          onTap: () {
            interstitialAd.loadInterstitialAd();
            if (!carCheck) {
              setState(() {
                chip1 = 'Mercedes';
                chip2 = 'Bmw';
                chip3 = 'Audi';
                carClicked = true;
              });
            }
            value2 = categorie;
            setState(() {
              getSearchApi2(categorie);
            });
          },
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            alignment: Alignment.center,
            color: Colors.teal.shade400,
            height: 30.h,
            child: Text(
              categorie,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15.5.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SafeArea top(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const WallpaperAppText(),
          dropDown(),
          SearchBar(func: ({value}) {
            setState(() {
              value2 = value;
            });
            if (value != '') {
              getSearchApi2(value);
            }
          }),
        ],
      ),
    );
  }

  Future getSearchApi2(value) async {
    print(value);
    List<Wallpapers> searchListWallpapers = await getSearchApi(value);
    setState(() => searchList = searchListWallpapers);
  }

  var dropwDownIndex = 2;
  Align dropDown() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: DropdownButton(
          borderRadius: BorderRadius.circular(8),
          onTap: (() {
            interstitialAd.loadInterstitialAd();
          }),
          focusColor: Colors.teal,
          iconEnabledColor: Colors.teal,
          onChanged: (value2) {
            setState(() {
              value = value2 as int;
            });
          },
          value: value,
          items: const [
            DropdownMenuItem(
              value: 1,
              child: Icon(
                Icons.view_agenda,
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: Icon(
                Icons.space_dashboard_rounded,
              ),
            ),
            DropdownMenuItem(
              value: 3,
              child: Icon(Icons.view_column),
            ),
          ],
        ),
      ),
    );
  }
}
