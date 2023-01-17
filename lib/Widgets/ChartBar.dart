import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekdayName;
  final double spendingAmount;
  final double spendingAmountPer;
  const ChartBar(
      {super.key,
      required this.weekdayName,
      required this.spendingAmount,
      required this.spendingAmountPer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 15.0,
            child: FittedBox(child: Text(spendingAmount.toStringAsFixed(0)))),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60.0,
          width: 10.0,
          child: Stack(
            children: [
              FractionallySizedBox(
                heightFactor: spendingAmountPer,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF55353),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.black),
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          weekdayName.toUpperCase(),
          style: const TextStyle(
            color: Color(0xFF143F6B),
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}