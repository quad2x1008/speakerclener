import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'ClsAdMob.dart';

export 'AdMobIds.dart';
export 'BannerAds.dart';
export 'NativeAds.dart';

RewardedInterstitialAd? _rewardedInterstitialAd;

class ClsAdMobReward {
  static void initRewardAd({isShow = false, Function()? callBack}) async {
    if (!(myAdModel.isAdShow ?? true) || myAdModel.adRewardInter != "1") {
      return;
    }
    if (_rewardedInterstitialAd == null) {
      RewardedInterstitialAd.load(
          adUnitId: myAdModel.admobRewardInter ?? "",
          request: AdRequest(),
          rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
            onAdLoaded: (RewardedInterstitialAd ad) {
              print('$ad loaded.');
              // Keep a reference to the ad so you can show it later.
              _rewardedInterstitialAd = ad;
              print(isShow);
              if (isShow) {
                showRewardAds(callBack: callBack);
              }
            },
            onAdFailedToLoad: (LoadAdError error) {
              EasyLoading.dismiss();
              print('RewardedInterstitialAd failed to load: $error');
            },
          ));
    }
  }

  static void showRewardAds({
    isShow = false,
    required Function()? callBack,
    Function()? onFailed,
  }) async {
    if (!(myAdModel.isAdShow ?? true)) {
      return;
    }
    if (_rewardedInterstitialAd != null) {
      print('showFullAds');
      _rewardedInterstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedInterstitialAd ad) {
          currentCount = 0;
          EasyLoading.dismiss();
          // FirebaseLog.logEvent("InterAdShow");
          print('$ad onAdShowedFullScreenContent.');
        },
        onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          _rewardedInterstitialAd = null;
          initRewardAd();
          // if (callBack != null) {
          //   callBack();
          // }
          if (onFailed != null) onFailed();
        },
        onAdFailedToShowFullScreenContent: (RewardedInterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          _rewardedInterstitialAd = null;
          if (onFailed != null) onFailed();
        },
        onAdImpression: (RewardedInterstitialAd ad) => print('$ad impression occurred.'),
      );
      _rewardedInterstitialAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
        if (callBack != null) {
          callBack();
        }
      });
    } else {
      initRewardAd(isShow: isShow, callBack: callBack);
    }
  }
}
