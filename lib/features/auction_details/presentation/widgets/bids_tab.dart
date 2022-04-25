import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tradpool/App/app.dart';
import 'package:tradpool/Widgets/container.dart';
import 'package:tradpool/Widgets/text.dart';
import 'package:tradpool/core/consts.dart';

Widget bidsTap(String image, Text title, String value, String title2,
    String value2, int index) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Image.asset(
                "assets/images/Mask.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: w(10),
            ),
            Column(
              children: [
               title,
                SizedBox(
                  height: h(3),
                ),
                text(text: value, fontsize: 11.sp, color: AppColor.hintcolor),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                text(text: title2, fontsize: 12.sp, color: AppColor.hintcolor),
                SizedBox(
                  height: h(3),
                ),
                text(text: value2, fontsize: 14.sp, color: AppColor.blue),

              
              ],
            ),
          ],
        )
      ],
    ),
  );
}
