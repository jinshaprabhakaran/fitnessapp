
import 'package:fitnessappadmin/global/constants/images/images.dart';
import 'package:fitnessappadmin/modules/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashBoardController>(context, listen: false).onInit();
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
        return Scaffold(
          backgroundColor: KColors().kWhite,
          body: dashboardCtrl.screens[dashboardCtrl.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: dashboardCtrl.selectedIndex,
            onTap: (value) {
              dashboardCtrl.setIndex(value);
            },
       backgroundColor: KColors().kWhite,
      
            selectedItemColor: KColors().kBlack,
            unselectedItemColor: KColors().kGrey,
            selectedFontSize: 17,
            unselectedFontSize: 13,
           
            items: [
              BottomNavigationBarItem(
                label: 'Attendance',
                icon: Image.asset(attendance, width: 30.w, height: 30.h),
              ),
              BottomNavigationBarItem(
                label: 'Register',
                icon: Icon(Icons.add, size: 30.sp),
              ),
              BottomNavigationBarItem(
                label: 'Users',
                icon: Icon(Icons.account_circle, size: 30.sp),
              ),
            ],
          ),
        );
      },
    );
  }
}
