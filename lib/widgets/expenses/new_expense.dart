import 'dart:math';

import 'package:expense_tracker/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/database/models/expense.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _expenseTitleController = TextEditingController();
  final _expenseAmountController = TextEditingController();
  static const String routeName = "New Expense";

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _showDatePicker () async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year -1, now.month, now.day);
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now
    );
    setState(() {
    _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData () {
    final enteredAmount = double.tryParse(_expenseAmountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount == 0;
    if (_expenseTitleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      MyDialogs.showCustomDialog(
          context,
          dialogMessage: "Please enter a valid title, amount and date",
          isDismissible: true,
          title: "Invalid input",
          positiveActionName: "Okay",
          positiveAction: () {
          Navigator.pop(context);
          },
      );
      return;
    } else {
      widget.onAddExpense(
          Expense(
              title: _expenseTitleController.text,
              date: _selectedDate!,
              amount: enteredAmount,
              category: _selectedCategory
          )
      );
      Navigator.pop(context);
    }

  }

  @override
  void dispose() {
    _expenseTitleController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _expenseTitleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _expenseAmountController,
              decoration: const InputDecoration(
                prefix: Icon(Icons.attach_money_rounded),
                label: Text("Amount"),
              ),
            ),
          ),
              const SizedBox(width: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null ?
                  "No Date Selected" :
                  dateFormatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: (){
                        _showDatePicker();
                      },
                      icon: const Icon(Icons.calendar_month),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                  items: Category.values.map(
                          (category) => DropdownMenuItem(
                            value: category,
                              child:Text(
                                category.name.toUpperCase(),
                              ),
                          ),
                  ).toList(),
                  onChanged: (category){
                    if (category == null) {
                      return;
                    }
                    setState(() {
                    _selectedCategory = category;
                    });
                  }
              ),
              const Spacer(),
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: _submitExpenseData,
                  child: const Text("Add Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
