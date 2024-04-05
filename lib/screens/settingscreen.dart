import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:speakerclener/Utils/ClsRateDialog.dart';
import 'package:speakerclener/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

String AppName = "Speaker Cleaner Water eject";
String privacy = "https://sites.google.com/view/nktechprivacy";
String share_msg = 'Hey use this wonderful app for learn something new.\n';
String playStrorUrl = "https://play.google.com/store/apps/details?id=${packageInfo!.packageName}";
String appStoreUrl = "";
String playStoreMoreApp = "https://play.google.com/store/apps/developer?id=NK+Tech+Apps";
String appStoreMoreApp = "";

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {


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
                  SizedBox(height: 30.r,),
                  Container(
                    margin: EdgeInsets.all(20.r),
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(10.sp)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(Platform.isIOS ? appStoreMoreApp : playStoreMoreApp),mode: LaunchMode.externalApplication);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "More Apps",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                ),
                                Icon(
                                  Icons.apps_rounded,
                                  color: Color(0xff147ADD),
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.15),
                          height: 25.r,
                        ),
                        GestureDetector(
                          onTap: () {
                            shareApp();
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Share App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                ),
                                Icon(
                                  CupertinoIcons.share,
                                  color: Color(0xff147ADD),
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.15),
                          height: 25.r,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(context: context, barrierDismissible: true, builder: (context) => ClsRateDialog());
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rate App",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                ),
                                Icon(
                                  CupertinoIcons.star_circle_fill,
                                  color: Color(0xff147ADD),
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.black.withOpacity(0.15),
                          height: 25.r,
                        ),
                        GestureDetector(
                          onTap: () {
                            launchUrlString(
                              privacy,
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp, letterSpacing: 2, color: Color(0xff147ADD)),
                                ),
                                Icon(
                                  Icons.policy_rounded,
                                  color: Color(0xff147ADD),
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
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
