import 'dart:io';

import 'package:appdebug_font_package/appdebug_font_package.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/dashboard_controller.dart';

// ignore: must_be_immutable
class UploadPhotoWidget extends StatelessWidget {
 UploadPhotoWidget({super.key,required this.title,required this.length,required this.value,required this.onPressed});
final String title;

final double value;
final String length;
Function()? onPressed;
  @override
  Widget build(BuildContext context) {
     return Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
           Gap(20.h),
           SmoothPageIndicator(
                        controller: dashboardCtrl.pageController,
                        count: 7,
                        effect:  WormEffect(type: WormType.thin,
                          dotHeight: 6,
                          dotWidth: 20,
                          dotColor: KColors().kBlack,
                          activeDotColor: Colors.green,
                        ),
                      ),
          Gap(40.h),
         KStyles().semiBold20(text: 'Complete your registration'),  
        Gap(20.h),
       KStyles().med17(text: title),
       Gap(20.h),
        Center(
          child: GestureDetector(
            onTap: () {
            dashboardCtrl.showPicker(context: context);
            },
            child: Container(
           width: 150.w,height: 150.h,decoration: BoxDecoration(color: KColors().kWhite.withOpacity(0.8),shape: BoxShape.circle),
              child: dashboardCtrl.galleryFile != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                      dashboardCtrl.galleryFile ?? File(''),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        ),
      Gap(50.h),
   SizedBox(width: double.infinity,height: 40.h,
     child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: onPressed, child: KStyles().med15(text: 'Submit',color: KColors().kWhite)),
   )
       
      ],),
    );
  });
  }
}