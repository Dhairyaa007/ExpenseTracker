import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';

class ExpenseList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const ExpenseList(
      {super.key, required this.transactions, required this.deleteTx});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.0,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'START TRACKING EXPENSES NOW...',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'SourceSansPro',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF55353)),
                ),
                const SizedBox(height: 10),
                Image.network(
                  'https://cdn.dribbble.com/users/1449854/screenshots/4136663/media/381780b56b2f28faa745c43b7ff88086.png',
                  fit: BoxFit.contain,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120.0,
                        height: 70.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            //strokeAlign: StrokeAlign.center,
                            color: const Color(0xFF143F6B),
                            width: 3,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                            '\$ ${transactions[index].amount.toString()}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color(0xFFF55353),
                                fontSize: 16,
                                fontFamily: 'SourceSansPro',
                                fontWeight: FontWeight.bold)),
                      ),
                      Column(
                        children: [
                          Text(transactions[index].title,
                              style: const TextStyle(
                                color: Color(0xFF143F6B),
                                fontSize: 17,
                                fontFamily: 'SourceSansPro',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3,
                              )),
                          Text(
                              DateFormat('yMMMd').format(
                                transactions[index].date,
                              ),
                              style: const TextStyle(
                                color: Color(0xFF143F6B),
                                fontSize: 14,
                                fontFamily: 'SourceSansPro',
                              )),
                        ],
                      ),
                      Container(
                          width: 40.0,
                          height: 40.0,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: IconButton(
                              onPressed: () => deleteTx(transactions[index].id),
                              icon: const Icon(
                                Icons.delete,
                                size: 20,
                                color: Color(0xFFF55353),
                              )))
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}