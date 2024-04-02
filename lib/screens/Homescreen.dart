import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:speakerclener/Utils/autoclean.dart';
import 'package:speakerclener/Utils/bluetooth.dart';
import 'package:speakerclener/Utils/manualCleaner.dart';
import 'package:speakerclener/Utils/microphon.dart';
import 'package:speakerclener/Utils/sixscreen.dart';
import 'package:speakerclener/Utils/soundtest.dart';
import 'package:speakerclener/ads/BannerAds.dart';
import 'package:speakerclener/ads/ClsAdMob.dart';
import 'package:speakerclener/customclass/color.dart';
import 'package:speakerclener/screens/exitScreen.dart';
import 'package:speakerclener/screens/settingscreen.dart';

// BluetoothDevice? btDevice;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  double setVolumeValue = 0.2;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeVolume();
    });
  }

  Future<void> _initializeVolume() async {
    try {
      double? volume = await FlutterVolumeController.getVolume();
      setState(() {
        setVolumeValue = volume ?? 0.2;
      });

      FlutterVolumeController.addListener((volume) {
        setState(() {
          setVolumeValue = volume;
        });
      });
    } catch (e) {
      print("Error initializing volume: $e");
    }
  }

  @override
  void dispose() {
    FlutterVolumeController.removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => ExitScreen(),
            ));
        return Future.value(false);
      },
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10.h, left: 15.w),
                                      child: Text("Speaker Cleaner", style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 25.sp,
                                        color: themeColor
                                      ),),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => Settingscreen()));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10.h, right: 10.h),
                                        child: Image.asset("assets/setting.png",color: themeColor, height: 22.h, width: 22.w,)
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 0.20.sh,
                                width: 0.90.sw,
                                margin: EdgeInsets.only(top: 30.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xff147ADD),
                                  borderRadius: BorderRadius.circular(15.5.sp),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0, left: 15),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            "VOLUME", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontFamily: "Poppins",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: 15.w, top: 8.h),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Set to maximum volume for better result",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Slider(
                                              min: 0,
                                              max: 1,
                                              activeColor: Colors.white,
                                              inactiveColor: Colors.white70,
                                              onChanged: (double value) {
                                                setVolumeValue = value;
                                                FlutterVolumeController.setVolume(setVolumeValue);
                                                FlutterVolumeController.updateShowSystemUI(false);
                                                setState(() {});
                                              },
                                              value: setVolumeValue,
                                            ),
                                          ),
                                    ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10.h),
                                child: Text("which gadget would you like \n to clean?",
                                   textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: "Poppinsreg",
                                    color: Color(0xff147ADD),
                                  ),
                                )
                              ),


                              Padding(
                                padding:  EdgeInsets.only(top: 10, left: 20.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const AutoCleanscreen()));
                                          },
                                          child: Container(
                                            height: 0.25.sh,
                                            width: 0.45.sw,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/grid.png"),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 25.h),
                                                    child: Image.asset("assets/autotesting.png", height: 0.10.sh,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.h),
                                                    child: Text("Auto Speaker \n Cleaner",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 15.sp,
                                                      color: Color(0xff147ADD)
                                                       ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => Manualcleaner()));
                                          },
                                          child: Container(
                                            height: 0.25.sh,
                                            width: 0.45.sw,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/grid.png"),
                                                  fit: BoxFit.fill
                                                )
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 25.h),
                                                    child: Image.asset("assets/manual.png", height: 0.10.sh,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
                                                    child: Text("Manual \n Speaker Cleaner",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 15.sp,
                                                          color: Color(0xff147ADD)
                                                      ),

                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            checkBTdevice();
                                          },
                                          child: Container(
                                            height: 0.25.sh,
                                            width: 0.45.sw,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/grid.png"),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 25.h),
                                                    child: Image.asset("assets/headphone.png", height: 0.10.sh,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
                                                    child: Text("Headset",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 15.sp,
                                                          color: Color(0xff147ADD)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const MicTesting()));
                                          },
                                          child: Container(
                                            height: 0.25.sh,
                                            width: 0.45.sw,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/grid.png"),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 25.h),
                                                    child: Image.asset("assets/mictest.png", height: 0.10.sh,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
                                                    child: Text("Microphone",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 15.sp,
                                                          color: Color(0xff147ADD)
                                                      ),

                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const SoundScreen()));
                                          },
                                          child: Container(
                                            height: 0.25.sh,
                                            width: 0.45.sw,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/grid.png"),
                                                    fit: BoxFit.fill
                                                ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 30.h),
                                                    child: Image.asset("assets/Sound.png", height: 0.10.sh,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
                                                    child: Text("Sound",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 15.sp,
                                                          color: Color(0xff147ADD)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) => const HowCleanscreen()));
                                          },
                                          child: Container(
                                            height: 0.25.sh,
                                            width: 0.45.sw,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage("assets/grid.png"),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 30.h),
                                                    child: Image.asset("assets/idea 1.png", height: 0.10.sh,),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5.h, left: 2.w, right: 2.w),
                                                    child: Text(
                                                      "How to Use",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 15.sp,
                                                          color: Color(0xff147ADD)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
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
  void checkBTdevice() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BlueThootScreen();
        },
      ),
    );

    // if (selectedDevice != null) {
    //   print('Connect -> selected ' + selectedDevice.address);
    //   // session.write(KeyDevice, json.encode({"1": selectedDevice.address, "2": selectedDevice.name, "3": 2}));
    //   // startQuizScreen(selectedDevice);
    // } else {
    //   print('Connect -> no device selected');
    // }
  }
}
