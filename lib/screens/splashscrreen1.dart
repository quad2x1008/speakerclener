import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:speakerclener/ads/AdModel.dart';
import 'package:speakerclener/ads/AppLifecycleReactor.dart';
import 'package:speakerclener/ads/AppOpenAdManager.dart';
import 'package:speakerclener/ads/ClsAdMob.dart';
import 'package:speakerclener/ads/FirebaseLog.dart';
import 'package:speakerclener/customclass/key.dart';
import 'package:speakerclener/main.dart';
import 'package:speakerclener/screens/Homescreen.dart';
import 'package:speakerclener/screens/Splashscreen.dart';
import 'package:http/http.dart' as http;

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {

  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());
    } catch (e) {
      print(e);
    }
  }

  Future<void> initPlugin() async {
    try {
      final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(seconds: 3));
        // Request system's tracking authorization dialog

        await AppTrackingTransparency.requestTrackingAuthorization().whenComplete(() {
          concentForm();
        });
      } else {
        concentForm();
      }
    } on PlatformException {
      concentForm();
    }
  }

  void concentForm() async {
    // await ConsentInformation.instance.reset();
    // print("Date==${DateTime.now().compareTo(DateTime(2023, 6, 15).add(Duration(days: 5)))}");
    if (!(DateTime.now().compareTo(DateTime(2023, 6, 17).add(Duration(days: 5))) > 0)) {
      loadAdsId();
      return;
    }

    ConsentDebugSettings debugSettings = ConsentDebugSettings(debugGeography: DebugGeography.debugGeographyEea, testIdentifiers: deviceList);

    ConsentRequestParameters params = ConsentRequestParameters(consentDebugSettings: debugSettings);

    ConsentInformation.instance.requestConsentInfoUpdate(params, () {
      ConsentForm.loadConsentForm((ConsentForm consentForm) async {
        var status = await ConsentInformation.instance.getConsentStatus();
        print("Test==${status}");
        if (status == ConsentStatus.required) {
          consentForm.show(
                (FormError? formError) {
              // Handle dismissal by reloading form
              loadAdsId();
            },
          );
        } else {
          loadAdsId();
        }
      },
            (formError) {
          loadAdsId();
          // Handle the error
        },
      );
    }, (error) {
      print("Error==${error.message}");
      loadAdsId();
    });
  }

  Future<void> loadAdsId() async {
    FirebaseLog.logEvent("APPSTART");
    List<Future> futureList = [];
    futureList.add(loadHttpJson());
    futureList.add(Future.delayed(Duration(seconds: 3)));

    await Future.wait<dynamic>(futureList);

    if (myAdModel.adSplash == '1') {
      if (DateTime.now().compareTo(DateTime.parse('2023-06-01').add(Duration(days: 5))) > 0) {
        AppOpenAdManager()
          ..showAdIfAvailable(callBack: () {});
      }
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return session.read(KEY.firstScreen) ?? true ? SplashScreen() : HomePage();
        },
      ),
    );
  }

  String adJosoURL = "http://s1.bninfotech.co.in/AdsJson/${packageInfo?.packageName}.json";
  String testUrl = "https://myapp1008-282c5.web.app/com.test.json";

  Future<void> loadHttpJson() async {
    try {
      http.Response response = await http.get(Uri.parse(kDebugMode ? testUrl : adJosoURL));
      int statusCode = response.statusCode;
      if (statusCode == 200) {
        Map jsonMap = json.decode(response.body);
        if (Platform.isAndroid) {
          myAdModel = AdModel.fromJson(jsonMap['android']);
        } else {
          myAdModel = AdModel.fromJson(jsonMap['ios']);
        }
      }
    } catch (e) {
      print(e);
    }
    try {
      if (myAdModel.packageName == null) {
        String data = await rootBundle.loadString("assets/ads.json");
        final jsonMap = jsonDecode(data);
        if (Platform.isAndroid) {
          myAdModel = AdModel.fromJson(jsonMap['android']);
        } else {
          myAdModel = AdModel.fromJson(jsonMap['ios']);
        }
      }
      AppOpenAdManager appOpenAdManager = AppOpenAdManager()
        ..loadAd();
      var _appLifecycleReactor = AppLifecycleReactor(appOpenAdManager: appOpenAdManager);
      _appLifecycleReactor.listenToAppStateChanges();
      ClsAdMob.initAd();
    } catch (e) {
      print(e);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child:  SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50.h),
                    child: Image.asset("assets/applogo.png", height: 0.30.sh, width: 0.30.sh
                      ,),
                  ),
                  Container(
                    child: Text(
                      "Speaker Cleaner",
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: const Color(0xff147ADD),
                        fontFamily: "Poppins"
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
