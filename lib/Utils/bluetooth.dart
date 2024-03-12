import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakerclener/Utils/autoclean.dart';
import 'package:speakerclener/ads/BannerAds.dart';

class BlueThootScreen extends StatefulWidget {
  const BlueThootScreen({Key? key}) : super(key: key);

  @override
  State<BlueThootScreen> createState() => _BlueThootScreenState();
}

class _BlueThootScreenState extends State<BlueThootScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isDeviceConnected = false;
  String connectedDeviceName = '';

  @override
  void initState() {
    super.initState();
    listFider();
    checkDeviceConnection();
  }

  Future<void> checkDeviceConnection() async {
    List<BluetoothDevice> connectedDevices =
    await flutterBlue.connectedDevices;

    if (connectedDevices.isNotEmpty) {
      setState(() {
        isDeviceConnected = true;
        print("isconnected:--$isDeviceConnected");
        connectedDeviceName = connectedDevices.first.name;
        print("connecteddevice:--$connectedDeviceName");
      });
    }else{
      print("aaaaa  ${connectedDevices.length}");
    }
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
                  Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
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
                            "Headset Cleaning",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff147ADD),
                              fontSize: 30.sp,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                        Container(
                          height: 0.30.sh,
                          width: 0.30.sh,
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/headphone.png"))),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                          child: Text(
                            "Please plug in your headphones \n to continue",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 20.sp,
                                fontFamily: "Poppinsreg"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "If you have a Bluetooth headphone device \n then connect it with your phone",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 15.sp,
                                fontFamily: "Poppinsreg"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: TextButton(
                            onPressed: () {
                              AppSettings.openBluetoothSettings();
                            },
                            child: Text(
                              isDeviceConnected
                                  ? "Connected to a Device"
                                  : "Connect to a Device",
                              style: TextStyle(
                                  color: Color(0xff147ADD),
                                  fontSize: 24.sp,
                                  fontFamily: "Poppinsreg"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BannerAds()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> listFider() async {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });
  }
}
