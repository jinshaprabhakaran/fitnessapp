import 'dart:io';

import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/modules/dashboard/view/user_details_screen.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../controller/dashboard_controller.dart';
import 'payment_screen.view.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors().kWhite,
      body: Consumer<DashBoardController>(builder: (context, dashboardCtrl, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50.h),
              Center(child: KStyles().bold22(text: 'Users')),
              Gap(10.h),
              ListView.builder(
                shrinkWrap: true,
                itemCount: dashboardCtrl.userModel.length,
                itemBuilder: (context, index) {
                  final user = dashboardCtrl.userModel[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return UserDetailsScreen(index: index);
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(flex: 1,
                            child: Container(
                              width: 50.w,
                              height: 50.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(File(user.dp)),
                                ),
                              ),
                            ),
                          ),
                          Gap(10.w),
                          Expanded(flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KStyles().semiBold17(text: user.name),
                                KStyles().reg17(text: user.phonenumber),
                              ],
                            ),
                          ),
                          Gap(20.w),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PaymentHistoryScreen(user: user);
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  KStyles().semiBold12(text: 'Payment History', color: Colors.green),
                                  const Icon(Icons.arrow_forward, color: Colors.green, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
