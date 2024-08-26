import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';

class CalendarWeekDays extends StatelessWidget {
  const CalendarWeekDays({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         
           weekDays('Mon'),
           weekDays('Tue'),
          weekDays('Wed'),
           weekDays('Thu'),
          weekDays('Fri'),
          weekDays('Sat'),
          weekDays('Sun'),
        ],
      ),
    );
  }

  Widget weekDays(String day) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child:KStyles().semiBold14(
       text:  day,  
      ),
    );
  }
}
