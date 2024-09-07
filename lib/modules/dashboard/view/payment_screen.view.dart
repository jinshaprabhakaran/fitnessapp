import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:fitnessappadmin/modules/dashboard/model/usermodel.dart';
import 'package:flutter/material.dart';



class PaymentHistoryScreen extends StatelessWidget {
  final UserModel user;

  const PaymentHistoryScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    List<String> allMonths = [
      'January', 'February', 'March', 'April',
      'May', 'June', 'July', 'August',
      'September', 'October', 'November', 'December',
    ];

    List<PaymentHistory> userPayments = List.generate(12, (i) {
      String month = allMonths[i];

      if (user.paymentHistory != null) {
        return user.paymentHistory!.firstWhere(
          (payment) => payment.month == month,
          orElse: () => PaymentHistory(month: month, type: 'none', status: 'unpaid', date: ''),
        );
      } else {
        return PaymentHistory(month: month, type: 'none', status: 'unpaid', date: '');
      }
    });

    return Scaffold(
      backgroundColor: KColors().kWhite,
      appBar: AppBar(
        centerTitle: true,
        title: KStyles().semiBold18(text: 'Payment History'),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
             Row(
              children: [
                Expanded(child: KStyles().bold14(text:'Month')
               ),
                 Expanded(child: KStyles().bold14(text:'Status')
               ),
                Expanded(child: KStyles().bold14(text:'Mode of Payment')
               ),
                Expanded(child: KStyles().bold14(text:'Date')
               ),
              ],
            ),
            const SizedBox(height: 8.0),
            Divider(thickness: 2, color: Colors.grey[300]),
            const SizedBox(height: 8.0),
           
            Expanded(
              child: ListView.builder(
                itemCount: userPayments.length,
                itemBuilder: (context, index) {
                  final payment = userPayments[index];
                  return Row(
                    children: [
                      Expanded(child: KStyles().med14(text:payment.month , )),
                      Expanded(child:  KStyles().med14(text:payment.status == 'paid' ? 'Paid' : 'Unpaid',
                      color: payment.status == 'paid' ? Colors.green : Colors.red)),
                      Expanded(child: Text(payment.type == 'none' ? 'N/A' : payment.type, )),
                      Expanded(child: Text(payment.status == 'paid' ? payment.date : '--',)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
