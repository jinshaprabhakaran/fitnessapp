import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';

class ProfileRowWidget extends StatelessWidget {
  const ProfileRowWidget({super.key,required this.title,required this.value});
 final String title;
 final String value;
  @override
  Widget build(BuildContext context) {
    return  Row(children: [ KStyles().semiBold15(text: title),
    
  KStyles().med15(text: value)  ],);
  }
}