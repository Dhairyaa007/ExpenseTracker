import 'package:expensetracker/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpenseTrackerHome());
}

class ExpenseTrackerHome extends StatelessWidget {
  const ExpenseTrackerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}