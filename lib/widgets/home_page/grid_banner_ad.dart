import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaper_app/services/banner_ad.dart';

class GridBannerAd extends StatelessWidget {
  BannerAds gridBannerAd = BannerAds();
  @override
  Widget build(BuildContext context) {
    gridBannerAd.looadStaticBannerAd(
      'ca-app-pub-1426970669505408/7287835919',
      size: AdSize.banner,
    );
    return gridBannerAd.bannerWidget();
  }
}
