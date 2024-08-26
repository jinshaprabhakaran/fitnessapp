import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    required this.currentMonth,
    required this.pageController,
    required this.onMonthChanged,
    super.key,
  });

  final DateTime currentMonth;
  final PageController pageController;
  final ValueChanged<int> onMonthChanged;

  @override
  Widget build(BuildContext context) {
    bool isLastMonthOfYear = currentMonth.month == 12;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (pageController.page! > 0) {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
         KStyles().semiBold14(text: DateFormat('MMMM').format(currentMonth),),
          DropdownButton<int>(
            value: currentMonth.year,
            onChanged: (int? year) {
              if (year != null) {
                int yearDiff = DateTime.now().year - year;
                int monthIndex = 12 * yearDiff + currentMonth.month - 1;
                pageController.jumpToPage(monthIndex);
                onMonthChanged(monthIndex);
              }
            },
            items: [
              for (int year = DateTime.now().year;
                  year <= DateTime.now().year + 10;
                  year++)
                DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (!isLastMonthOfYear) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
