import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:speakerclener/ads/BannerAds.dart';
import 'package:speakerclener/ads/ClsAdMob.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({Key? key});

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  late AudioPlayer _audioPlayer;
  int? _selectedIndex;

  List<String> audioList = [
    'assets/audio/a1.mp3',
    'assets/audio/a2.mp3',
    'assets/audio/a3.mp3',
    'assets/audio/a4.mp3',
    'assets/audio/a5.mp3',
    'assets/audio/a6.mp3',
    'assets/audio/a7.mp3',
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _selectedIndex = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(int index) async {
    if (_selectedIndex == index) {
      if (_audioPlayer.playing) {
        await _audioPlayer.pause();
      } else {
        await _audioPlayer.play();
      }
    } else {
      await _audioPlayer.setAsset(audioList[index]);
      setState(() {
        _selectedIndex = index;
      });
      await _audioPlayer.play();
    }
  }

  IconData _getIcon(int index) {
    return _selectedIndex == index ? Icons.pause : Icons.play_arrow;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        return backButton(context);
      },
      child: Scaffold(
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
                                backButton(context);
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
                            margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                            child: Text(
                                "Sound Cleaning",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xff147ADD),
                                  fontSize: 30.sp,
                                  fontFamily: "Montserrat"
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding:  EdgeInsets.only(top: 10.h, left: 30.w, right: 30.w),
                              child: ListView.builder(
                                itemCount: audioList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text('Audio ${index + 1}', style: TextStyle(
                                      color: Color(0xff147ADD),
                                      fontSize: 18.sp,
                                      fontFamily: "Poppinsreg"
                                    ),),
                                    trailing: IconButton(
                                      icon: Icon(_getIcon(index), size: 25.sp,  color: Color(0xff147ADD), ),
                                      onPressed: () => _playAudio(index),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
