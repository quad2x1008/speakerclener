import 'dart:io';

import 'package:flutter/material.dart';

import 'ClsAdMob.dart';

class NativeAds extends StatefulWidget {
  int adType;
  Color? adFontColor;

  NativeAds({this.adType = 1, this.adFontColor = Colors.black});

  @override
  State<StatefulWidget> createState() {
    return new NativeAdsState();
  }
}

class NativeAdsState extends State<NativeAds> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _isAdLoaded,
        child: Container(
          child: AdWidget(ad: _ad!),
          alignment: Alignment.bottomCenter,
        ));
  }

  NativeAd? _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      _ad = NativeAd(
        adUnitId: myAdModel.admobNativeid ?? "",
        request: adRequest,
        nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium),
        listener: NativeAdListener(
          onAdLoaded: (_) {
            Future.delayed(Duration(seconds: 3), () {
              setState(() {
                _isAdLoaded = true;
              });
            });
          },
          onAdFailedToLoad: (ad, error) {
            // Releases an ad resource when it fails to load
            ad.dispose();
            print('Ad load failed (code=${error.code} message=${error.message})');
          },
        ),
      );
      _ad?.load();
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
