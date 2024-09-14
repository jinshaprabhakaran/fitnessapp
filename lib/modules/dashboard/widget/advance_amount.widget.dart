import 'dart:developer';

import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AdvanceAmountSelectionScreen extends StatefulWidget {
  final double value;
  final String length;
  
  final Function() onSubmit;

  const AdvanceAmountSelectionScreen({super.key, 
    required this.value,
    required this.length,
    
    required this.onSubmit,
  });

  @override
  State<AdvanceAmountSelectionScreen> createState() => _AdvanceAmountSelectionScreenState();
}

class _AdvanceAmountSelectionScreenState extends State<AdvanceAmountSelectionScreen> {
  @override
  Widget build(BuildContext context) {
  
   return Consumer<DashBoardController>(
        builder: (context, dashboardCtrl, child) {
      return  

    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
              SmoothPageIndicator(
                controller: dashboardCtrl.pageController,
                count: 9,
                effect: WormEffect(
                  type: WormType.thin,
                  dotHeight: 6,
                  dotWidth: 20,
                  dotColor: KColors().kBlack,
                  activeDotColor: Colors.green,
                ),
              ),
              Gap(40.h),
              
            KStyles().semiBold20(text: 'Complete your registration'),
            Gap(20.h),
              
              CheckboxListTile(
                title: KStyles().med17(text: "Have you paid the advance amount?"),
                value: dashboardCtrl.hasPaidAdvance,
                onChanged: (bool? value) {
                  setState(() {
                    dashboardCtrl.hasPaidAdvance = value ?? false;
                    log(dashboardCtrl.hasPaidAdvance.toString());
                  });
                  
                  
                },
              ),
            ],
          ),
          SizedBox(height: 40.h,),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: widget.onSubmit,
                child: KStyles().med15(text: 'Submit', color: KColors().kWhite)),
          ),
          Gap(10.h),
        ],
      ),
    );
  });
  }
}
