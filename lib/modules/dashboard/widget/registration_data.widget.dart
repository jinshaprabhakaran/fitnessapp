import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/global/constants/widgets/textfield.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../controller/dashboard_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegistrationDetails extends StatelessWidget {
  const RegistrationDetails({super.key,required this.title,required this.hintText,required this.textEditingController,required this.value,required this.length});
final String title;
final String hintText;
final TextEditingController textEditingController;
final double value;
final String length;

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
       Gap(10.h),
       TextFieldWidget(
        hintText: hintText, readOnly: false, boxWidth: double.infinity, textAlign: TextAlign.left, textColor: KColors().kBlack, textEditingController: textEditingController)
   ,Gap(70.h),
   SizedBox(width: double.infinity,height: 40.h,
     child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      onPressed: (){
      dashboardCtrl.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                  
     }, child: KStyles().med15(text: 'Next',color: KColors().kWhite)),
   )
       
      ],),
    );
  });
  }
}