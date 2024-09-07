import 'dart:io';
import 'package:fitnessappadmin/global/constants/db_key.dart';
import 'package:fitnessappadmin/modules/dashboard/model/usermodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'global/config/config.dart';
import 'global/constants/providers/providers_list.dart';
import 'global/constants/routes/routes.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(CheckInCheckOutStatusAdapter());
  Hive.registerAdapter(PaymentHistoryAdapter());

  userBox = await Hive.openBox<UserModel>(Config.dbName);

  runApp(MultiProvider(providers: providersList, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? ScreenUtilInit(
            designSize: const Size(333, 675),
            child: CupertinoApp(
                title: 'FitnessApp',
                routes: routes,
                initialRoute: '/',
                theme: CupertinoThemeData(
                    barBackgroundColor: KColors().kWhite,
                    primaryColor: Colors.black),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  DefaultWidgetsLocalizations.delegate,
                  DefaultMaterialLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate
                ]),
          )
        : ScreenUtilInit(
            designSize: const Size(333, 675),
            child: MaterialApp(
                routes: routes,
                title: 'FitnessApp',
                initialRoute: '/',
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light().copyWith(
                  searchBarTheme: SearchBarThemeData(
                      backgroundColor:
                          MaterialStateProperty.all(KColors().kWhite)),
                )));
  }
}
