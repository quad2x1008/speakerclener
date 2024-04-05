import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speakerclener/Utils/rate_dialog.dart';
import 'package:speakerclener/ads/EntryAnimation.dart';
import 'package:speakerclener/screens/settingscreen.dart';
import 'package:url_launcher/url_launcher.dart';

/// Create By Parth 06-04-2023
class ClsRateDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ClsRateDialogState();
  }
}

class ClsRateDialogState extends State<ClsRateDialog> {
  double _rating = 5;

  @override
  Widget build(BuildContext context) {
    return RateDialog(
      imageWidget: Container(),
      title: Column(
        children: [
          Container(
            height: 100.r,
            width: 100.r,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage(
                      "assets/app_icon.png",
                    ),
                    fit: BoxFit.fill)),
          ),
          SizedBox(
            height: 20.r,
          ),
          Text("$AppName", textAlign: TextAlign.center, style: TextStyle(fontSize: 18.r, fontWeight: FontWeight.w600, fontFamily: 'vecna')),
        ],
      ),
      description: Column(
        children: [
          Text('Help us out by rating our app!\nYour feedback is important to us.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14.r, fontFamily: 'Surface-Medium')),
          SizedBox(
            height: 20.r,
          ),
          Divider(
            color: Color(0xff382312),
            height: 20.r,
          ),
          RatingBar.builder(
            initialRating: _rating,
            wrapAlignment: WrapAlignment.center,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 8),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              _rating = rating;
              setState(() {});
            },
          ),
          Divider(
            color: Color(0xff382312),
            height: 20.r,
          ),
        ],
      ),
      entryAnimation: EntryAnimation.RIGHT,
      onlyOkButton: true,
      buttonOkColor: Color(0xff382312),
      buttonOkText: Text(
        "Rate Us",
        style: TextStyle(color: Colors.white),
      ),
      onOkButtonPressed: () {
          launchUrl(Uri.parse(Platform.isIOS ? appStoreUrl : playStrorUrl),mode: LaunchMode.externalApplication);
          Navigator.pop(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
