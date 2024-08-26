import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/modules/dashboard/widget/profile_data.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/dashboard_controller.dart';
import '../widget/calendar_months.widget.dart';
import '../widget/calendar_weeks.widget.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, this.index});
 final int ? index;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final PageController _pageController =
      PageController(initialPage: DateTime.now().month - 1);

  DateTime currentMonth = DateTime.now();

  bool selectedcurrentyear = false;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: KColors().kWhite,
    body: Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
    return
     Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children:
         [
      Gap(70.h),
     ProfileRowWidget(title: 'Name : ', value: dashboardCtrl.userModel[widget.index ??  0].name),
     Gap(5.h),
      ProfileRowWidget(title: 'Age : ', value: dashboardCtrl.userModel[widget.index ??  0].age),
       Gap(5.h),
      ProfileRowWidget(title: 'Weight : ', value: dashboardCtrl.userModel[widget.index ??  0].weight),
       Gap(5.h),
      ProfileRowWidget(title: 'Height : ', value: dashboardCtrl.userModel[widget.index ??  0].height),
       Gap(5.h),
      ProfileRowWidget(title: 'Blood Group : ', value: dashboardCtrl.userModel[widget.index ??  0].bloodgroup.toString()),
      Gap(20.h),
     SizedBox(height: 400.h,
        child: Column(children: [ 
             CalendarMonth(
              currentMonth: currentMonth,
              pageController: _pageController,
              onMonthChanged: (index) {
                setState(() {
                  currentMonth = DateTime(currentMonth.year, index + 1, 1);
                });
              },
            ),
         Gap(8.h),
            const CalendarWeekDays(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentMonth = DateTime(currentMonth.year, index + 1, 1);
                
                  });
                },
                itemCount: 12 * 10, 
                itemBuilder: (context, pageIndex) {
                  DateTime month =
                      DateTime(currentMonth.year, (pageIndex % 12) + 1, 1);
                  return buildCalendar(month);
                },
              ),
            ),

            ]))
          ],),
    );
      }
    ));}

 Widget buildCalendar(DateTime month) {
  int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
  DateTime firstDayOfMonth = DateTime(month.year, month.month, 1);
  int weekdayOfFirstDay = firstDayOfMonth.weekday;
  DateTime lastDayOfPreviousMonth = firstDayOfMonth.subtract(const Duration(days: 1));
  int daysInPreviousMonth = lastDayOfPreviousMonth.day;

  return Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      
      ),
      itemCount: daysInMonth + weekdayOfFirstDay - 1,
      itemBuilder: (context, index) {
        if (index < weekdayOfFirstDay - 1) {
          int previousMonthDay = daysInPreviousMonth - (weekdayOfFirstDay - index) + 2;
          return Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide.none,
                left: BorderSide(width: 0.5, color: Colors.grey),
                right: BorderSide(width: 0.5, color: Colors.grey),
                bottom: BorderSide(width: 0.5, color: Colors.grey),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              previousMonthDay.toString(),
              style: const TextStyle(color: Colors.grey),
            ),
          );
        } else {
          DateTime date = DateTime(month.year, month.month, index - weekdayOfFirstDay + 2);
          String text = date.day.toString();

         
          if (widget.index != null && widget.index! < dashboardCtrl.userModel.length) {
           
            final status = dashboardCtrl.userModel[widget.index!].dailyStatus?[DateFormat('yyyy-MM-dd').format(date)];

            return Container(
              decoration:  BoxDecoration(color: (status != null && status.isCheckedIn && status.isCheckedOut ) ?  Colors.green : Colors.transparent ,
                border: const Border(
                  top: BorderSide.none,
                  left: BorderSide(width: 0.5, color: Colors.grey),
                  right: BorderSide(width: 0.5, color: Colors.grey),
                  bottom: BorderSide(width: 0.5, color: Colors.grey),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: KStyles().med15(text: text)
                    ),
                  ),
                
                
                ],
              ),
            );
          } else {
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide.none,
                  left: BorderSide(width: 1.0, color: Colors.grey),
                  right: BorderSide(width: 1.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              child: Center(
                child:KStyles().med15(text:
                  text,
               
                ),
              ),
            );
          }
        }
      },
    );
  });
}

}

  
