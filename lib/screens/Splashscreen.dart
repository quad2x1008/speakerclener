import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakerclener/customclass/key.dart';
import 'package:speakerclener/main.dart';
import 'package:speakerclener/screens/Homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SplashScreen1(onNext: () {
                // Navigate to the next page when the button is tapped
                _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.ease);
              }),
              SplashScreen2(),
            ],
          )
        ],
      ),
    );
  }
}

class SplashScreen1 extends StatefulWidget {
  final VoidCallback onNext;

  const SplashScreen1({Key? key, required this.onNext}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sh,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Splshscreen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: Text(
                      "Speaker Cleaner", style: TextStyle(
                      fontSize: 32.sp,
                      color: Color(0xff147ADD),
                      fontFamily: "Montserrat"
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Image.asset(
                      "assets/firstimage.png",
                      height: 0.45.sh,
                      width: 0.35.sh,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
                    child: Text(
                      "Welcome to Speaker \n Cleaner!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontFamily: "Poppins"
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text(
                      "Revive your headphones, amplify \n your speakers, and test your \n microphone with ease.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: "Poppinsreg",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onNext,
                    child: Container(
                      margin: EdgeInsets.only(top: 30.h),
                      height: 0.07.sh,
                      width: 0.35.sw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.5.sp),
                          border: Border.all(color: Color(0xff0B78DE), width: 3.sp),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 20.sp, color: Color(0xff0B78DE), fontFamily: "Poppinsreg"),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.w),
                              child: Image.asset(
                                "assets/aarow.png",
                                color: Color(0xff0B78DE),
                                height: 21.h,
                                width: 20.w,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class SplashScreen2 extends StatefulWidget {
  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 1.sh,
            width: 1.sh,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Splshscreen.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text(
                      "Speaker Cleaner", style: TextStyle(
                        fontSize: 32.sp,
                        color: Color(0xff147ADD),
                        fontFamily: "Montserrat"
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Image.asset(
                      "assets/secoundimage.png",
                      height: 0.45.sh,
                      width: 0.35.sh,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15.h),
                    child: Text(
                      "Crystal-Clear Audio",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontFamily: "Poppins"
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Effortlessly clean your headphones \n and speakers, restoring audio \n clarity for an immersive listening \nexperience",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.white.withOpacity(0.8),
                          fontFamily: "Poppinsreg"
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      session.write(KEY.firstScreen, false);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30.h),
                      height: 0.07.sh,
                      width: 0.35.sw,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.5.sp),
                          border: Border.all(color: Color(0xff0B78DE), width: 3.sp)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 25.sp, color: Color(0xff0B78DE),
                                    fontFamily: "Poppinsreg"
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: Image.asset(
                                "assets/aarow.png",
                                color: Color(0xff0B78DE),
                                height: 20.h,
                                width: 21.w,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
