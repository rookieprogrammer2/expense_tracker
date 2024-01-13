import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
/// One
class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses =  [
    Expense(title: "Flutter Course", date: DateTime.now(), amount: 19.99, category: Category.work),
    Expense(title: "Movie Night-Out", date: DateTime.now(), amount: 14, category: Category.leisure),
  ];

  void _OpenAddExpenseOverlay () {
    showModalBottomSheet(context: context, builder: (ctx) => const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculexpensionator'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _OpenAddExpenseOverlay,
              icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ExpensesList(expenses: _registeredExpenses)),
        ],
      ),
    );
  }
}