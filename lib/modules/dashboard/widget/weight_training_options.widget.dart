
import 'dart:developer';

import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controller/dashboard_controller.dart';
import '../model/usermodel.dart';

class WeightSelectionScreen extends StatefulWidget {
 final double value;
  final String length;
  

  const WeightSelectionScreen({super.key, 
    required this.value,
    required this.length,

  });


  @override
  State<WeightSelectionScreen> createState() => _WeightSelectionScreenState();
}

class _WeightSelectionScreenState extends State<WeightSelectionScreen> {
 
  
  final List<WeightOption> weightOptions = [
    WeightOption(optionName: 'Cardio', feeAmount: 1500.0, advanceAmount: 2000.0),
    WeightOption(optionName: 'Aerobics', feeAmount: 1200.0, advanceAmount: 2000.0),
    WeightOption(optionName: 'Yoga', feeAmount: 1000.0, advanceAmount: 1500.0),
  ];

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
              
              KStyles().med15(text: 'Select Weight Training Type'),
              Gap(20.h),
              ListView.builder(shrinkWrap: true,
                itemCount: weightOptions.length,
                itemBuilder: (context, index) {
                  WeightOption option = weightOptions[index];
                  return RadioListTile<WeightOption>(dense: false,
                  contentPadding: EdgeInsets.only(left: 1),
                    title: KStyles().semiBold18(text:option.optionName )
                     ,
                    subtitle: Text.rich(
            TextSpan(
              text: 'Fee : ',style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.grey) ,
              children: <InlineSpan>[
                TextSpan(
                  text: '₹${option.feeAmount.toString()}',
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),
                ),
                const TextSpan(
                  text: '   Advance: ',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.grey),
                ),
                TextSpan(
                  text:'₹${option.advanceAmount.toString()}',
                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),
                )
              ]
            ),
                    ),
                    value: option,
                    groupValue: dashboardCtrl.selectedWeightOption,
                    onChanged: (WeightOption? value) {
                      setState(() {
                        dashboardCtrl.selectedWeightOption = value;
                        
                        log(dashboardCtrl.selectedWeightOption!.advanceAmount.toString());
                      });
                    },
                  );
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
              onPressed: () {
                if (dashboardCtrl.selectedWeightOption != null) {
                 
                  dashboardCtrl.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                } else {
                  
                }
              },
              child: KStyles().med15(text: 'Next', color: KColors().kWhite),
            ),
          ),
          Gap(10.h),
        ],
      ),
    );
  });
  }
}

