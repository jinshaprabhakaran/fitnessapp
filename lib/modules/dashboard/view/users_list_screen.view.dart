import 'dart:io';

import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/modules/dashboard/view/user_details_screen.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../controller/dashboard_controller.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold( backgroundColor:KColors().kWhite,
     body: Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
   return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
           Gap(50.h),
        Center(child: KStyles().bold22(text: 'Users')),
        Gap(10.h),
        ListView.builder(shrinkWrap: true,
          itemCount: dashboardCtrl.userModel.length,
          itemBuilder: (context,index){
       return GestureDetector(
        onTap: (){
         Navigator.of(context).push((MaterialPageRoute(builder: (context){return UserDetailsScreen(index:index);})));
        },
         child: Padding(
           padding:  EdgeInsets.only(bottom: 10.h),
           child: Row(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              Container(width: 50.w,height: 50.h,
                decoration: BoxDecoration( shape: BoxShape.circle,
                  image:DecorationImage(fit: BoxFit.cover,
                    image: FileImage(File(dashboardCtrl.userModel[index].dp),)),),),
                    Gap(20.w),
               Column(
                 children: [
                   KStyles().semiBold17(text: dashboardCtrl.userModel[index].name,),
                   KStyles().reg17(text: dashboardCtrl.userModel[index].phonenumber,),
                 ],
               ),
               
             ],
           ),
         ),
       );
        })
      ],),
    );
      })
    );
  }
}