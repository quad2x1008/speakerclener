import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:speakerclener/ads/AppOpenAdManager.dart';

import 'AppLifecycleReactor.dart';
import 'ClsAdMob.dart';

class AdModel {
  String? platform;
  String? packageName;
  String? appVersion;
  bool? isAdShow;
  String? admobAppid;
  String? admobBannerid;
  String? admobInterid;
  String? admobAppopenid;
  String? admobNativeid;
  String? admobRewardInter;
  String? interCount;
  String? adSplash;
  String? adInter;
  String? adAppopen;
  String? adNative;
  String? adBanner;
  String? adRewardInter;
  String? privacyUrl;

  AdModel(
      {this.platform,
      this.packageName,
      this.appVersion,
      this.isAdShow,
      this.admobAppid,
      this.admobBannerid,
      this.admobInterid,
      this.admobAppopenid,
      this.admobNativeid,
      this.admobRewardInter,
      this.interCount,
      this.adSplash,
      this.adInter,
      this.adAppopen,
      this.adNative,
      this.adBanner,
      this.adRewardInter,
      this.privacyUrl});

  AdModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    packageName = json['package_name'];
    appVersion = json['app_version'];
    isAdShow = json['is_ad_show'];
    admobAppid = json['admob_appid'];
    admobBannerid = json['admob_bannerid'];
    admobInterid = json['admob_interid'];
    admobAppopenid = json['admob_appopenid'];
    admobNativeid = json['admob_nativeid'];
    admobRewardInter = json['admob_rewardInter'];
    interCount = json['inter_count'];
    adSplash = json['ad_splash'];
    adInter = json['ad_inter'];
    adAppopen = json['ad_appopen'];
    adNative = json['ad_native'];
    adBanner = json['ad_banner'];
    adRewardInter = json['ad_rewardInter'];
    privacyUrl = json['privacy_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['package_name'] = this.packageName;
    data['app_version'] = this.appVersion;
    data['is_ad_show'] = this.isAdShow;
    data['admob_appid'] = this.admobAppid;
    data['admob_bannerid'] = this.admobBannerid;
    data['admob_interid'] = this.admobInterid;
    data['admob_appopenid'] = this.admobAppopenid;
    data['admob_nativeid'] = this.admobNativeid;
    data['admob_rewardInter'] = this.admobRewardInter;
    data['inter_count'] = this.interCount;
    data['ad_splash'] = this.adSplash;
    data['ad_inter'] = this.adInter;
    data['ad_appopen'] = this.adAppopen;
    data['ad_native'] = this.adNative;
    data['ad_banner'] = this.adBanner;
    data['ad_rewardInter'] = this.adRewardInter;
    data['privacy_url'] = this.privacyUrl;
    return data;
  }
}

