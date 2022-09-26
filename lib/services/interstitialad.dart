// ignore_for_file: avoid_print

import 'package:google_mobile_ads/google_mobile_ads.dart';

int index = 2;

class InterstitialAds {
  final AdRequest _request2 = const AdRequest();

  late InterstitialAd _intAd;

  loadInterstitialAd({bool isWallpaperSetButtonClicked = false}) async {
    if (index % 3 == 0 || isWallpaperSetButtonClicked) {
      print('adIndex: $index');
      InterstitialAd.load(
        adUnitId: 'ca-app-pub-1426970669505408/4509962470',
        request: _request2,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (e) {
            _intAd = e;
            _intAd.show();
            _intAd.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _intAd.dispose();
              },
              onAdFailedToShowFullScreenContent: ((ad, error) {
                _intAd.dispose();
              }),
            );
          },
          onAdFailedToLoad: (error) {},
        ),
      );
    } else {}
    index++;
  }
}
