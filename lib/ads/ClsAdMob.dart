import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'AdModel.dart';

export 'AdMobIds.dart';
export 'BannerAds.dart';
export 'NativeAds.dart';

// int adCount = 2;
int currentCount = 0;
// const bool isAdShow= true;
AdModel myAdModel = AdModel();

const List<String> deviceList = [
  "85B8854A98DF8759A112BDDBF2D6ABFC"
];

const AdRequest adRequest = AdRequest();
InterstitialAd? _interstitialAd;
DateTime lastAdShow = DateTime.now();

class ClsAdMob {
  static void initAd({isShow = false}) async {
    print('$currentCount >= ${myAdModel.interCount}');
    if (!(myAdModel.isAdShow ?? true) || myAdModel.adInter != "1") {
      return;
    }
    if (_interstitialAd == null) {
      InterstitialAd.load(
        adUnitId: myAdModel.admobInterid ?? "",
        request: adRequest,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            print('InterstitialAd to load: ${ad.adUnitId}');
            _interstitialAd = ad;
            if (isShow) {
              _interstitialAd?.show();
            }
            // FirebaseLog.logEvent("InterAdLoad");
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ),
      );
    }
  }

  static void showFullAds({isShow = false, ignorCnt = false, isLoadMore = true, Function()? callBack}) async {
    if (!(myAdModel.isAdShow ?? true) || myAdModel.adInter != "1") {
      if (callBack != null) {
        callBack();
      }
      return;
    }
    print("Time Diff ${DateTime.now().difference(lastAdShow).inSeconds} ${currentCount}");
    if (currentCount >= int.parse(myAdModel.interCount ?? "0") || ignorCnt || DateTime.now().difference(lastAdShow).inSeconds > 60) {
      if (_interstitialAd != null) {
        print('showFullAds');
        lastAdShow = DateTime.now();
        _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) {
            currentCount = 0;
            // FirebaseLog.logEvent("InterAdShow");
            print('$ad onAdShowedFullScreenContent.');
          },
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            print('$ad onAdDismissedFullScreenContent.');
            ad.dispose();
            _interstitialAd = null;
            initAd();
            if (callBack != null) {
              callBack();
            }
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            initAd();
            _interstitialAd = null;
            if (callBack != null) {
              callBack();
            }
          },
          onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
        );
        _interstitialAd?.show();
      } else {
        initAd();
        if (callBack != null) {
          callBack();
        }
      }
    } else {
      currentCount++;
      if (callBack != null) {
        callBack();
      }
      if (_interstitialAd == null) {
        initAd(isShow: isShow);
      }
    }
  }
}

Future<bool> backButton(BuildContext context) {
  print("Test== Beck Press");
  ClsAdMob.showFullAds(callBack: () {
    print("Test== Dismiss");
    Navigator.pop(context);
    // ClsSound.playSound(SOUNDTYPE.Tap);
  });
  return Future.value(false);
}


