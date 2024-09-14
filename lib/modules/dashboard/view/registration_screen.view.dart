

import 'package:appdebug_font_package/appdebug_font_package.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/dashboard_controller.dart';
import '../model/usermodel.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
 late final  UserModel? userModel ;
  @override
  Widget build(BuildContext context) {
     return Consumer<DashBoardController>(
      builder: (context, dashboardCtrl, child) {
    return  Scaffold(
      appBar: AppBar(title: KStyles().bold20(text: 'Register'),centerTitle: true,),
    backgroundColor:KColors().kWhite,
    body: PageView.builder(
    
      controller:dashboardCtrl.pageController ,
      itemCount: 9,
      itemBuilder: (context, index) {
        return dashboardCtrl.changePage(index,context);
      },
    ),
    );
      
  
  });
}
}