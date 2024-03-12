import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
export 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ClsAdMob.dart';

class BannerAds extends StatefulWidget {
  AdSize? bannerSize;
  VoidCallback? voidCallback;
  BannerAds({this.bannerSize, this.voidCallback});

  @override
  State<StatefulWidget> createState() {
    return new BannerAdsState();
  }
}

class BannerAdsState extends State<BannerAds> {
  // var myBanner;
  bool isload = false;

  AdWidget? adWidget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isload,
        child: Container(
          alignment: Alignment.center,
          child: adWidget,
          color:  Colors.transparent,
          // width: myBanner?.size?.width.toDouble()??0,
          height: myBanner?.size.height.toDouble() ?? 0,
          constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: isload && myBanner!.size.height.toDouble() > 0
                  ? myBanner!.size.height.toDouble()
                  : 0),
        )
    );
  }

  BannerAd? myBanner;

  @override
  void initState() {
    try {
      bannerSize = widget.bannerSize;
      WidgetsBinding.instance.addPostFrameCallback((_) => loadBanner());
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  AdSize? bannerSize;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    if (widget.voidCallback != null) widget.voidCallback!();
    super.setState(fn);
  }

  void loadBanner() async {
   try{
     // bannerSize = widget.bannerSize ??
     //     await AdSize.getAnchoredAdaptiveBannerAdSize(
     //         MediaQuery.of(context).orientation, 1.sw.truncate());
   }catch(e){
     print(e);
   }
   if(!(myAdModel.isAdShow??true)||myAdModel.adInter!="1"){
     return;
   }
    myBanner = BannerAd(
      adUnitId: myAdModel.admobBannerid??"",
      size: bannerSize ?? AdSize.banner,
      request: adRequest,
      listener: BannerAdListener(onAdLoaded: (value) {
        isload = true;
        myBanner = value as BannerAd?;
        adWidget = AdWidget(ad: myBanner!);
        log('adSize=${myBanner!.size.height.toDouble()}==${myBanner!.size.width.toDouble()}');
        setState(() {});
      }, onAdFailedToLoad: (ad, error) {
        isload = false;
        setState(() {});
      }),
    );
    myBanner!.load();
  }
}
