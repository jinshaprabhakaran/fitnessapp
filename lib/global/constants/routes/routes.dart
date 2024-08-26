import 'package:fitnessappadmin/modules/dashboard/view/dashboard_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/registration_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/user_details_screen.view.dart';
import 'package:fitnessappadmin/modules/dashboard/view/users_list_screen.view.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
    '/' : (BuildContext context) => const DashBoardScreen(),
    'register' : (BuildContext context) => const RegistrationScreen(),
    'users' : (BuildContext context) => const UsersListScreen(),
    'userDetails' : (BuildContext context) => const UserDetailsScreen()

};