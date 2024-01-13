import 'package:expense_tracker/database/models/expense.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses/new_expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  static const String routeName= "Expenses Screen";
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses =  [
    Expense(title: "Flutter Course", date: DateTime.now(), amount: 19.99, category: Category.work),
    Expense(title: "Movie Night-Out", date: DateTime.now(), amount: 14, category: Category.leisure),
  ];


  @override
  Widget build(BuildContext context) {
    Widget pageContent = const Center(
      child: Text(
          "Looks like you don't have any expenses. Hurray!",
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      pageContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: pageContent,
          ),
        ],
      ),
    );
  }

  void _openAddExpenseOverlay () {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) =>  NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense (Expense expense) {
    setState(() {_registeredExpenses.add(expense);});
  }

  void _removeExpense (Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
    final removedExpenseIndex = _registeredExpenses.indexOf(expense);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          content: const Text("Expense deleted"),
          action: SnackBarAction(
              label: "Undo",
              onPressed: () {
                setState(() {
                  _registeredExpenses.insert(removedExpenseIndex, expense);
                });
              },
          ),
        ),
    );
  }
}