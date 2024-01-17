import 'package:expense_tracker/database/models/expense.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/settings_sc.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  static const String routeName = "expenses_screen";

  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(title: "Flutter Course", date: DateTime.now(), amount: 14, category: Category.learning),
    Expense(title: "Travelling", date: DateTime.now(), amount: 500, category: Category.travelling),
    Expense(title: "MacDeez", date: DateTime.now(), amount: 85, category: Category.leisure),
    Expense(title: "Groceries", date: DateTime.now(), amount: 150, category: Category.essentials),
    Expense(title: "Car Ins. Payment", date: DateTime.now(), amount: 3000, category: Category.payments),
    Expense(title: "Electricity Bill", date: DateTime.now(), amount: 500, category: Category.bills),
  ];
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openAddExpenseOverlay();
        },
        child: const Icon(
          Icons.add_box_rounded,
          size: 25,
        ),
      ),
      appBar: tabIndex == 0
          ? AppBar(
              title: const Text(
                "SpendWise",
              ),
            )
          : AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        themeProvider.toggleTheme();
                      });
                    },
                    icon: themeProvider.isDark() == true
                        ? const Icon(
                      Icons.dark_mode_rounded,
                      size: 25,
                      color: Colors.black,
                    )
                        : const Icon(
                      Icons.light_mode_rounded,
                      size: 25,
                      color: Colors.yellow,
                    ),
                ),
              ],
              title: const Text(
                "Settings",
              ),
            ),
      bottomNavigationBar: bottomAppBar(),
      body: tabIndex == 0
          ? Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Chart(registeredExpenses: _registeredExpenses),
                ),
                Expanded(
                  child: pageContent,
                ),
              ],
            )
          : const SettingsScreen(),
    );
  }

  BottomAppBar bottomAppBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.hardEdge,
      notchMargin: 8,
      child: BottomNavigationBar(
        unselectedItemColor: Colors.white,
          currentIndex: tabIndex,
          onTap: (value) {
            setState(() {
              tabIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.home_outlined),
                ),
                label: "Home"),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              activeIcon: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.settings),
              ),
              label: "Settings",
            )
          ]),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      enableDrag: true,
      isScrollControlled: true,
      showDragHandle: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final removedExpenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
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


