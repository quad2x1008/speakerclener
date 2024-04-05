import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:speakerclener/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

String AppName = "Speaker Cleaner Water eject";

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  String privacy = "https://sites.google.com/view/nktechprivacy";
  String share_msg = 'Hey use this wonderful app for learn something new.\n';
  String playStrorUrl = "https://play.google.com/store/apps/details?id=${packageInfo!.packageName}";
  String appStoreUrl = "https://apps.apple.com/us/app/icecream-recipes-in-gujrati/id1249927202";
  String playStoreMoreApp = "https://play.google.com/store/apps/developer?id=NK+Tech+Apps";
  String appStoreMoreApp = "https://apps.apple.com/ky/developer/pt-patel/id1259901941";

  void shareApp() {
    String message = "$share_msg";
    if (playStrorUrl.isNotEmpty) {
      message += 'For PlayStore:$playStrorUrl';
    }
    if (appStoreUrl.isNotEmpty) {
      message += 'For AppStore:$appStoreUrl';
    }
    Share.share(
      '$message',
      subject: AppName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sw,
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 0.06.sh,
                        width: 0.06.sh,
                        margin: EdgeInsets.only(left: 20.w, top: 10.h),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/arrowback.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
                    child: Text(
                      "Settings",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xff147ADD), fontSize: 30.sp, fontFamily: "Montserrat"),
                    ),
                  ),
                  Container(
                    height: 200.sp,
                    width: 300.sp,
                    margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 30.h),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25.5.sp)),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30.h, left: 10.w),
                          child: GestureDetector(
                            onTap: () {
                              launchUrl(Uri.parse(Platform.isIOS ? appStoreMoreApp : playStoreMoreApp));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 35.w),
                                    child: Text(
                                      "More Apps",
                                      style: TextStyle(
                                          fontSize: 20.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 50.w),
                                  child: Icon(
                                    Icons.more_horiz_outlined,
                                    color: Color(0xff147ADD),
                                    size: 30.sp,
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30.h, left: 10.w),
                          child: GestureDetector(
                            onTap: () {
                              shareApp();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 35.w),
                                    child: Text(
                                      "Share App",
                                      style: TextStyle(
                                          fontSize: 20.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 50.w),
                                  child: Icon(
                                    Icons.share,
                                    color: Color(0xff147ADD),
                                    size: 25.sp,
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30.h, left: 10.w),
                          child: GestureDetector(
                            onTap: () {
                              launchUrlString(
                                privacy,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 35.w),
                                    child: Text(
                                      "Privacy Policy",
                                      style: TextStyle(
                                          fontSize: 20.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 50.w),
                                  child: Icon(
                                    Icons.privacy_tip,
                                    color: Color(0xff147ADD),
                                    size: 25.sp,
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
