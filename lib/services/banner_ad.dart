// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds {
  late BannerAd staticAd;
  bool staticAdLoaded = false;

  AdRequest request = AdRequest();

  Future<void> looadStaticBannerAd(String id,
      {AdSize size = AdSize.fullBanner}) async {
    staticAd = BannerAd(
      adUnitId: id,
      size: size,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          staticAdLoaded = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    )..load();
  }

  SizedBox bannerWidget() {
    return SizedBox(
      width: staticAd.size.width.toDouble(),
      height: staticAd.size.height.toDouble(),
      child: AdWidget(
        ad: staticAd,
      ),
    );
  }
}
