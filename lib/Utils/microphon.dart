import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speakerclener/ads/BannerAds.dart';

class MicTesting extends StatefulWidget {
  const MicTesting({super.key});

  @override
  State<MicTesting> createState() => _MicTestingState();
}

class _MicTestingState extends State<MicTesting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sh,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: (){
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
                            "Mic Testing",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 30.sp,
                                fontFamily: "Montserrat"
                            ),
                          ),
                        ),
                        Container(
                          height: 0.20.sh,
                          width: 0.20.sh,
                          margin: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/microphone.png")
                            ),
                          ),
                        ),

                        Container(
                          child: Text(
                            "When water is trapped inside the phone, \n the microphone also becomes muffled, \n Tap to test mic",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 15.sp,
                                fontFamily: "Poppinsreg"
                            ),
                          ),
                        ),

                        Container(
                          height: 45.h,
                          width: 0.75.sw,
                          margin: EdgeInsets.only(top: 30.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                            ),
                            onPressed: () async {
                              await Navigator.push(context, MaterialPageRoute(builder: (_) => NoiseMeterApp()));
                            },
                            child: Text(
                              "Tap to Test",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
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

class NoiseMeterApp extends StatefulWidget {
  @override
  _NoiseMeterAppState createState() => _NoiseMeterAppState();
}

class _NoiseMeterAppState extends State<NoiseMeterApp> {
  bool _isRecording = false;
  NoiseReading? _latestReading;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  NoiseMeter? noiseMeter;

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
  }

  void onData(NoiseReading noiseReading) =>
      setState(() => _latestReading = noiseReading);

  void onError(Object error) {
    print(error);
    stop();
  }

  /// Check if microphone permission is granted.
  Future<bool> checkPermission() async => await Permission.microphone.isGranted;

  /// Request the microphone permission.
  Future<void> requestPermission() async =>
      await Permission.microphone.request();

  /// Start noise sampling.
  Future<void> start() async {
    noiseMeter ??= NoiseMeter();
    if (!(await checkPermission())) await requestPermission();
    _noiseSubscription = noiseMeter?.noise.listen(onData, onError: onError);
    setState(() => _isRecording = true);
  }

  /// Stop sampling.
  void stop() {
    _noiseSubscription?.cancel();
    setState(() => _isRecording = false);
  }

  @override

  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sh,
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [

                        Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: (){
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
                            "Mic Testing",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 30.sp,
                                fontFamily: "Montserrat"
                            ),
                          ),
                        ),

                        Container(
                          height: 0.20.sh,
                          width: 0.20.sh,
                          margin: EdgeInsets.only(top: 25.h),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/micicon1.png"),
                            )
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: Text(
                            "Speak to test",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.blue
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: Text(
                            "To improve your test performance, \n position the microphone correctly, speacl clearly \n and find a quite place to take the test.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.sp
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: Text(
                                "MIC: 1/R",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.h),
                              height: 25.h,
                              width: 0.75.sw,
                              child: LinearProgressIndicator(
                                value:  _latestReading?.meanDecibel != null
                                    ? _latestReading!.meanDecibel / 100
                                    : 0,
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              child: Text(
                                "MIC: 2/L",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              height: 25.h,
                              width: 0.75.sw,
                              child: LinearProgressIndicator(
                                value: _latestReading?.maxDecibel != null
                                    ? _latestReading!.maxDecibel/ 100
                                    : 0,
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                              ),
                            ),

                          ],
                        ),

                        Container(
                          height: 45.h,
                          width: 0.75.sw,
                          margin: EdgeInsets.only(top: 30.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text("Done",style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp
                            ),),
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
