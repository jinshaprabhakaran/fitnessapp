import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../global/constants/widgets/check_box.widget.dart';
import '../controller/dashboard_controller.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
   return Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
    return  DefaultTabController(length: 2,
      child: Scaffold(
        appBar: AppBar(bottom:  
      TabBar(
        labelStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
        indicatorColor: KColors().kBlack,
            unselectedLabelColor: KColors().kGrey,
            dividerColor: Colors.transparent,
            automaticIndicatorColorAdjustment: false,
            padding: const EdgeInsets.only(bottom: 20,),
            labelColor: KColors().kBlack,
           overlayColor: const MaterialStatePropertyAll(Colors.black12),
            tabs: const [
              Tab(text: 'check in' ,),
               Tab(text: 'check out' ,),
         ],),
        title: KStyles().bold20(text: 'Attendance'),centerTitle: true,),
        backgroundColor:KColors().kWhite,
         body:
          TabBarView(children: [
         ListView.builder(shrinkWrap: true,
          itemCount: dashboardCtrl.checkInList.length,
          itemBuilder: (context,index){
              var user = dashboardCtrl.checkInList[index]; 
            return Padding(
              padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
              child: Container(padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(border: Border.all(color: KColors().kGrey)
                ),
                child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(children: [
                  KStyles().semiBold15(text:user.name ),
                  Gap(5.h),
                   KStyles().reg15(text:user.phonenumber),
                ],),
                 CheckBoxWidget(  
                  value: user.dailyStatus?[currentDate]?.isCheckedIn ?? false,
                   onChanged: (bool? value) {
                          setState(() {
                        if (value ?? false) {
                    dashboardCtrl.checkInUser(index);
                                 }
                                 });
                                 },
                          ),  
                ],),),
            );
          }),
      ListView.builder(shrinkWrap: true,
          itemCount: dashboardCtrl.checkOutList.length,
          itemBuilder: (context,index){
             var user = dashboardCtrl.checkOutList[index];
                   
            return Padding(
              padding: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
              child: Container(padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(border: Border.all(color: KColors().kGrey)),
                child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Column(children: [
                  KStyles().semiBold15(text:user.name ),
                  Gap(5.h),
                   KStyles().reg15(text:user.phonenumber),
                ],),
                 CheckBoxWidget(  
                            value: user.dailyStatus?[currentDate]?.isCheckedOut ?? false,
                            onChanged: (bool ? value) {
                              setState(() {
                              dashboardCtrl.checkOutUser(index);
                              });
                            },
                          ),  
                ],),),
            );
          })
          ]),
       ));
    
  });
  }
}