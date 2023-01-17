import '../Widgets/ChartBar.dart';
import '../Models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyExpenseChart extends StatelessWidget {
  const WeeklyExpenseChart(this.recentTransactions, {super.key});
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((txValue) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  weekdayName: txValue['day'].toString(),
                  spendingAmount: double.parse(txValue['amount'].toString()),
                  spendingAmountPer: totalSpending == 0.0
                      ? 0.0
                      : (txValue['amount'] as double) / totalSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}