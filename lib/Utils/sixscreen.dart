import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakerclener/Utils/autoclean.dart';
import 'package:speakerclener/ads/BannerAds.dart';

class HowCleanscreen extends StatefulWidget {
  const HowCleanscreen({super.key});

  @override
  State<HowCleanscreen> createState() => _HowCleanscreenState();
}

class _HowCleanscreenState extends State<HowCleanscreen> {
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
                          margin: EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                          child: Text(
                            "How To Clean",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 30.sp,
                                fontFamily: "Montserrat"
                            ),
                          ),
                        ),
                        Container(
                          height: 0.25.sh,
                          width: 0.45.sw,
                          margin: EdgeInsets.only(top: 20.h),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/idea 1.png"), fit: BoxFit.fill
                            )
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30.h),
                          child: Text(
                            "Please follow these steps carefully \n to clean your speacker properly",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff147ADD),
                              fontSize: 18.sp,
                              fontFamily: "Poppinsreg"
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 30.h, left: 15.w),
                            child: Text(
                              ". Turn your phones's volume to maximum", style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 15.sp,
                                fontFamily: "Poppinsreg"
                            ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 15.h,  left: 15.w),
                            child: Text(
                              ". Speaker should be facing down", style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 15.sp,
                                fontFamily: "Poppinsreg"
                            ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 15.h,  left: 15.w),
                            child: Text(
                              ". Soak water with tissue paper", style: TextStyle(
                                color: Color(0xff147ADD),
                                fontSize: 15.sp,
                                fontFamily: "Poppinsreg"
                            ),
                            ),
                          ),
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AutoCleanscreen()));
                            },
                            child: Text("Start Cleaning",style: TextStyle(
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
