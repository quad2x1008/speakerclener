import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:speakerclener/ads/BannerAds.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class MyPainter extends CustomPainter {
  final List<int> oneCycleData;

  MyPainter(this.oneCycleData);

  @override
  void paint(Canvas canvas, Size size) {
    var i = 0;
    List<Offset> maxPoints = [];

    final t = size.width / (oneCycleData.length - 1);
    for (var _i = 0, _len = oneCycleData.length; _i < _len; _i++) {
      maxPoints.add(Offset(
          t * i,
          size.height / 2 -
              oneCycleData[_i].toDouble() / 32767.0 * size.height / 2));
      i++;
    }

    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, maxPoints, paint);
  }

  @override
  bool shouldRepaint(MyPainter old) {
    if (oneCycleData != old.oneCycleData) {
      return true;
    }
    return false;
  }
}

class _MyAppState extends State<MyApp> {
  bool isPlaying = false;
  double frequency = 20;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int>? oneCycleData;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20,
          ),

          child: SafeArea(
            child: Column(
              children: [
                Column(
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
                          margin: EdgeInsets.only(left: 5.w, top: 10.h),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/arrowback.png"),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                      child: Text(
                        "Manual Cleaning",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff147ADD),
                            fontSize: 30.sp,
                            fontFamily: "Montserrat"
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h,),
                    Text("A Cycle's Snapshot With Real Data"),
                    SizedBox(height: 2.h),
                    Container(
                        height: 100.h,
                        width: double.infinity,
                        color: Colors.white54,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 0,
                        ),
                        child: oneCycleData != null
                            ? CustomPaint(
                          painter: MyPainter(oneCycleData!),
                        )
                            : Container()),
                    SizedBox(height: 2.h),
                    Text("A Cycle Data Length is " +
                        (sampleRate / this.frequency).round().toString() +
                        " on sample rate " +
                        sampleRate.toString()),
                    SizedBox(height: 5.h),
                    Divider(
                      color: Colors.red,
                    ),
                    SizedBox(height: 5.h),
                    CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.lightBlueAccent,
                        child: IconButton(
                            icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
                            onPressed: () {
                              isPlaying
                                  ? SoundGenerator.stop()
                                  : SoundGenerator.play();
                            })),
                    SizedBox(height: 5.h),
                    Divider(
                      color: Colors.red,
                    ),
                    SizedBox(height: 5.h),
                    Text("Wave Form"),
                    Center(
                        child: DropdownButton<waveTypes>(
                            value: this.waveType,
                            onChanged: (waveTypes? newValue) {
                              setState(() {
                                this.waveType = newValue!;
                                SoundGenerator.setWaveType(this.waveType);
                              });
                            },
                            items: waveTypes.values.map((waveTypes classType) {
                              return DropdownMenuItem<waveTypes>(
                                  value: classType,
                                  child: Text(classType.toString().split('.').last));
                            }).toList())),
                    SizedBox(height: 5.h),
                    Divider(
                      color: Colors.red,
                    ),
                    SizedBox(height: 5.h),
                    Text("Frequency"),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                                    this.frequency.toStringAsFixed(2) + " Hz")),
                          ),
                          Expanded(
                            flex: 8, // 60%
                            child: Slider(
                                min: 20,
                                max: 10000,
                                value: this.frequency,
                                onChanged: (_value) {
                                  setState(() {
                                    this.frequency = _value.toDouble();
                                    SoundGenerator.setFrequency(this.frequency);
                                  });
                                }),
                          ),
                        ],),),
                    SizedBox(height: 5),
                    Text("Balance"),
                    Container(
                        width: double.infinity,
                        height: 40.h,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Center(
                                    child: Text(this.balance.toStringAsFixed(2))),
                              ),
                              Expanded(
                                flex: 8, // 60%
                                child: Slider(
                                    min: -1,
                                    max: 1,
                                    value: this.balance,
                                    onChanged: (_value) {
                                      setState(() {
                                        this.balance = _value.toDouble();
                                        SoundGenerator.setBalance(this.balance);
                                      });
                                    }),
                              )
                            ])),
                    SizedBox(height: 5.h),
                    Text("Volume"),
                    Container(
                      width: double.infinity,
                      height: 40.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(this.volume.toStringAsFixed(2))),
                          ),
                          Expanded(
                            flex: 8, // 60%
                            child: Slider(
                                min: 0,
                                max: 1,
                                value: this.volume,
                                onChanged: (_value) {
                                  setState(() {
                                    this.volume = _value.toDouble();
                                    SoundGenerator.setVolume(this.volume);
                                  });
                                }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                BannerAds()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isPlaying = false;

    SoundGenerator.init(sampleRate);

    SoundGenerator.onIsPlayingChanged.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    SoundGenerator.onOneCycleDataHandler.listen((value) {
      setState(() {
        oneCycleData = value;
      });
    });

    SoundGenerator.setAutoUpdateOneCycleSample(true);
    SoundGenerator.refreshOneCycleData();
  }

  @override
  void dispose() {
    SoundGenerator.release();
    super.dispose();
  }

}

