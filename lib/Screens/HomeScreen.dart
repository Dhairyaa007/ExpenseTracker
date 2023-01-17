import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Widgets/WeeklyExpenseChart.dart';
import '../Models/transaction.dart';
import '../Widgets/ExpenseList.dart';
import '../Widgets/NewTransaction.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> userTransactions = [
    Transaction(
        id: DateTime.now().toString(),
        title: 'Grocery',
        amount: 200.0,
        date: DateTime.now()),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Mobile Recharge',
        amount: 55.50,
        date: DateFormat('yMMMd').parse('Dec 05, 2022')),
    Transaction(
        id: DateTime.now().toString(),
        title: 'Electricity Bill',
        amount: 50.0,
        date: DateFormat('yMMMd').parse('Dec 04, 2022'))
  ];

  List<Transaction> get recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime enteredDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: enteredDate);
    setState(() {
      userTransactions.add(newTx);
    });
  }

  void openModalSheet(BuildContext context) {
    setState(() {
      showModalBottomSheet(
          elevation: 5,
          context: context,
          builder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: UserTransaction(addTx: addNewTransaction),
            );
          });
    });
  }

  void deleteTx(String id) {
    setState(() {
      return userTransactions.removeWhere((Tx) => Tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF143F6B),
          title: const Text(
            'Expense Tracker',
            style: TextStyle(
              fontFamily: 'BebasNeue',
              fontSize: 24.0,
              letterSpacing: 2.0,
            ),
          ),
        ),
        body: Column(
          children: [
            // UserTransaction(addTx: addNewTransaction),
            WeeklyExpenseChart(recentTransactions),
            Expanded(
              child: ExpenseList(
                transactions: userTransactions,
                deleteTx: deleteTx,
              ),
            ),
            FloatingActionButton(
              backgroundColor: const Color(0xFF143F6B),
              child: const Icon(Icons.add),
              onPressed: () => openModalSheet(context),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}