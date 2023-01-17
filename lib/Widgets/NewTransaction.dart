import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key, required this.addTx});
  final Function addTx;

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final titleInput = TextEditingController();
  final amountInput = TextEditingController();
  final dateInput = TextEditingController();

  void submitTransaction() {
    String enteredTitleInput = titleInput.text;
    double enteredAmountInput = double.parse(amountInput.text);
    DateTime enteredDateInput = DateTime.parse(dateInput.text);
    if (enteredTitleInput.isEmpty ||
        enteredAmountInput <= 0 ||
        enteredDateInput != null) {
      return;
    }
    widget.addTx(enteredTitleInput, enteredAmountInput, enteredDateInput);
    Navigator.of(context).pop();
  }

  Future<void> selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    if (pickedDate != null) {
      String formattedDate = DateFormat('yMMMd').format(pickedDate);
      setState(() {
        dateInput.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      // decoration: const BoxDecoration(
      //   color: Colors.grey,
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(20.0),
      //     topRight: Radius.circular(20.0),
      //   ),
      // ),
      child: Column(children: [
        TextField(
          decoration: const InputDecoration(
              icon: Icon(Icons.title), labelText: 'Title:'),
          controller: titleInput,
          keyboardType: TextInputType.name,
          onSubmitted: (_) => submitTransaction(),
        ),
        TextField(
          decoration: const InputDecoration(
              icon: Icon(Icons.money), labelText: 'Amount:'),
          controller: amountInput,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => submitTransaction(),
        ),
        TextField(
          controller: dateInput,
          decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today), labelText: "Enter Date: "),
          readOnly: true,
          onTap: selectDate,
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFF143F6B))),
          onPressed: () => submitTransaction(),
          child: const Text('Add',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'SourceSansPro',
                  fontSize: 16.0)),
        ),
      ]),
    );
  }
}