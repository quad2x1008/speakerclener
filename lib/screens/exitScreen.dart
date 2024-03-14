import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExitScreen extends StatefulWidget {
  const ExitScreen({super.key});

  @override
  State<ExitScreen> createState() => _ExitScreenState();
}

class _ExitScreenState extends State<ExitScreen> {
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
                  Row(
                    children: [
                      Container(
                        height: 0.10.sh,
                        width: 0.10.sh,
                        margin: EdgeInsets.only(left: 50.w, top: 50.h),
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/autotesting.png"),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40.h, left: 8.w),
                        child: Text(
                          "SPEAKER CLEANER",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Text(
                      "ARE YOU SURE YOU WANT TO EXIT?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: "Poppins",
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
                              shape: StadiumBorder()
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Cancel",style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp
                          ),),
                        ),
                      ),

                      Container(
                        height: 45.h,
                        width: 0.35.sw,
                        margin: EdgeInsets.only(top: 25.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: StadiumBorder()
                          ),
                          onPressed: (){
                            setState(() {
                              exit(0);
                            });
                          },
                          child: Text("Exit",style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp
                          ),),
                        ),
                      )
                    ],
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
