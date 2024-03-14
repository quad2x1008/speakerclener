import 'dart:async';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakerclener/Utils/BlueTooth/BluetoothDeviceListEntry.dart';
import 'package:speakerclener/Utils/autoclean.dart';
import 'package:speakerclener/ads/BannerAds.dart';
import 'package:speakerclener/ads/ClsAdMob.dart';
import 'package:speakerclener/customclass/CustomDialoge.dart';
import 'package:speakerclener/screens/Homescreen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class BlueThootScreen extends StatefulWidget {

  const BlueThootScreen();

  @override
  State<BlueThootScreen> createState() => _BlueThootScreenState();
}


class _BlueThootScreenState extends State<BlueThootScreen>
    with WidgetsBindingObserver {
  // Availability

  List<BluetoothDevice> devicesList =
      List<BluetoothDevice>.empty(growable: true);
  bool isDeviceConnected = false;
  bool blucheck = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkBT();
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("Test==resume");
        _startDiscovery();
        setState(() {});
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
        break;
    }
  }

  void _startDiscovery() {


    // Setup a list of the bonded devices
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {

      devicesList = bondedDevices.where((device) => device.isConnected).toList();
      print("Test===${devicesList.length}");
      setState(() {

      });
    });
  }
bool isCleaningStart=false;
  @override
  Widget build(BuildContext context) {
    print("Test==List length ${devicesList.length}");
    if (devicesList.isEmpty) {
      return WillPopScope(
        onWillPop: (){
          return backButton(context);
        },
        child: Scaffold(
          body: Container(
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
                          margin:
                              EdgeInsets.only(top: 30.h, left: 10.w, right: 10.w),
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
                          margin:
                              EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
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
                              AppSettings.openBluetoothSettings().then((value) {
                                print("Test==open BT");
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                //   return HomePage();
                                // },));
                              });
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
                  // BannerAds()
                ],
              ),
            ),
          ),
        ),
      );
    } else{
      return HeadsetCleaning();
    }
  }

  void checkBT() async {

    // if (_isDiscovering) {
    //   _startDiscovery();
    // }
    FlutterBluetoothSerial.instance.onStateChanged().listen((event) {
      switch (event) {
        case BluetoothState.STATE_BLE_ON:
          _startDiscovery();
      }
    });

    if ((await FlutterBluetoothSerial.instance.isAvailable) ?? false) {
      _startDiscovery();
    }
  }
}

class HeadsetCleaning extends StatefulWidget {
  const HeadsetCleaning({Key? key}) : super(key: key);

  @override
  State<HeadsetCleaning> createState() => _HeadsetCleaningState();
}

class _HeadsetCleaningState extends State<HeadsetCleaning> {
  late Timer _timer;
  double progressValue = 0;
  double secondaryProgressValue = 0;
  late AudioPlayer player;
  bool isPlaying = false;
  bool isStarted = false;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setAsset('assets/audio/autoclaner.mp3');

    _timer = Timer.periodic(const Duration(milliseconds: 110), (Timer timer) {
      setState(() {
        if (progressValue < 100) {
          progressValue++;
          secondaryProgressValue = secondaryProgressValue + 2;
        } else {
          progressValue = 0;
          secondaryProgressValue = 0;
          _timer.cancel();
          stopAudio();
          isStarted = false;
          showComplateDailoge();
        }
      });
    });
    playAudio();
    isStarted = true;
  }

  void playAudio() async {
    await player.play();
  }

  void stopAudio() async {
    await player.stop();
    progressValue = 0;
    secondaryProgressValue = 0;
    _timer.cancel();
  }

  @override
  void dispose() {
    _timer.cancel();
    player.dispose();
    super.dispose();
  }

  Widget getNormalProgressStyle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 0.30.sh,
          width: 0.30.sh,
          child: SfRadialGauge(axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: 0.8,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.10,
                  color: const Color.fromARGB(30, 0, 169, 181),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                      value: progressValue,
                      width: 0.10.w,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 100,
                      animationType: AnimationType.linear)
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    positionFactor: 0,
                    widget: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cleaning",
                              style: TextStyle(
                                  color: Color(0xff147ADD),
                                  fontSize: 20.sp,
                                  fontFamily: "Poppinsreg")),
                          Text(progressValue.toStringAsFixed(0) + '%',
                              style: const TextStyle(
                                  color: Color(0xff147ADD),
                                  fontFamily: "Poppins")),
                        ],
                      ),
                    ),
                  )
                ])
          ]),
        ),
      ],
    );
  }

  void showStopDailoge() {
    if (isStarted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    height: ScreenUtil().setHeight(190),
                    width: ScreenUtil().setWidth(300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.5.sp),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.h, left: 30.w, right: 30.w),
                          child: Text(
                            "Stop Cleaning?",
                            style: TextStyle(
                                fontSize: 22.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 25.h, left: 10.w, right: 10.w),
                          child: Text(
                            "If you stop now, your speaker may not \n be fully clean",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 45.h,
                              width: 0.35.sw,
                              margin: EdgeInsets.only(top: 25.h),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: StadiumBorder()),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                              ),
                            ),
                            Container(
                              height: 45.h,
                              width: 0.35.sw,
                              margin: EdgeInsets.only(top: 25.h),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder()),
                                onPressed: () {
                                  setState(() {
                                    stopAudio();
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SecoundScreen()));
                                  });
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          });
    }
  }

  void showComplateDailoge() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                  height: ScreenUtil().setHeight(190),
                  width: ScreenUtil().setWidth(300),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.5.sp),
                      color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
                        child: Text(
                          "Cleaning Complete",
                          style: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 25.h, left: 10.w, right: 10.w),
                        child: Text(
                          "Your headset cleaning is complete",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 45.h,
                            width: 0.35.sw,
                            margin: EdgeInsets.only(top: 25.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              onPressed: () {
                                setState(() {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
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
                            margin: EdgeInsets.only(
                                top: 20.h, left: 10.w, right: 10.w),
                            child: Text(
                              "Headset Cleaning",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff147ADD),
                                  fontSize: 30.sp,
                                  fontFamily: "Montserrat"),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: getNormalProgressStyle()),
                          Container(
                            child: Text(
                              "Please follow these steps carefully.",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Color(0xff147ADD),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 30.h, left: 15.w),
                              child: Text(
                                ". Turn volume to maximum",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.sp,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 15.h, left: 15.w),
                              child: Text(
                                ". Speaker should be facing down",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                          Container(
                            height: 45.h,
                            width: 0.75.sw,
                            margin: EdgeInsets.only(top: 30.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder()),
                              onPressed: () {
                                showStopDailoge();
                              },
                              child: Text(
                                "Stop",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    BannerAds()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SecoundScreen extends StatelessWidget {
  const SecoundScreen({super.key});

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
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
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
                          margin: EdgeInsets.only(
                              top: 20.h, left: 10.w, right: 10.w),
                          child: Text(
                            "Auto Cleaning",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 30.sp,
                                fontFamily: "Montserrat"),
                          ),
                        ),
                        Container(
                          height: 0.20.sh,
                          width: 0.20.sh,
                          margin: EdgeInsets.only(top: 30.h),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/CORRECT1.png"),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.h),
                          child: Text(
                            "Cleaning is Complate",
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 21.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Poppins"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10.h),
                          child: Text(
                            "Is the sound still not working properly? \n Tap the restart button.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 15.sp,
                                fontFamily: "Poppinsreg"),
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 0.85.sw,
                          margin: EdgeInsets.only(top: 30.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              Navigator.pop(
                                  context); // Pop the current screen (SecoundScreen)
                              Navigator.pop(
                                  context); // Pop the previous screen (AutoCleanscreen)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AutoCleanscreen())); // Navigate back to AutoCleanscreen
                            },
                            child: Text(
                              "Restart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                          ),
                        ),
                        Container(
                          height: 40.h,
                          width: 0.85.sw,
                          margin: EdgeInsets.only(top: 20.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  BannerAds()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
