import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:expense_tracker/database/expense_dao.dart';
import 'package:expense_tracker/providers/date_provider.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/screens/chart/chart.dart';
import 'package:expense_tracker/screens/expenses_sc/expenses_sc_widgets/expenses_list.dart';
import 'package:expense_tracker/screens/expenses_sc/expenses_sc_widgets/new_expense.dart';
import 'package:expense_tracker/screens/settings_sc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ExpensesScreen extends StatefulWidget {
  static const String routeName = "expenses_screen";

  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    DateProvider dateProvider = Provider.of<DateProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
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
      bottomNavigationBar: bottomAppBar(),
      appBar: tabIndex == 0
          ? AppBar(
              title: SvgPicture.asset(
              "assets/icons/logo_white.svg",
              width: 190,
            ))
          : AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    themeProvider.toggleTheme();
                  },
                  icon: themeProvider.isDark() == true
                      ? const Icon(
                          Icons.light_mode_rounded,
                          size: 25,
                          color: Colors.yellow,
                        )
                      : const Icon(
                          Icons.dark_mode_rounded,
                          size: 25,
                          color: Colors.black,
                        ),
                ),
              ],
              title: const Text(
                "Settings",
                style:
                    TextStyle(
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                    ),
              ),
            ),
      body: tabIndex == 0
          ? Column(
              children: [

                Stack(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 53, 74, 83),
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    CalendarTimeline(
                      initialDate: dateProvider.currentDate,
                      firstDate: DateTime(DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime.now(),
                      onDateSelected: (newDate) {
                        dateProvider.changeCurrentDate(newDate);
                        // if (dateProvider.currentDate == newDate) {
                        //   dateProvider.toggleShowAllExpenses();
                        // } else {
                        //   return;
                        // }
                      },
                      leftMargin: 20,
                      selectableDayPredicate: (date) => date.day != 23,
                      monthColor: Colors.white,
                      dayColor: Colors.white,
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: Colors.black,
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Expanded(
                  flex: 1,
                  child: Chart(
                      expensesStream: ExpenseDAO.listenToExpensesByDate(
                          FirebaseAuth.instance.currentUser!.uid,
                          Provider.of<DateProvider>(context).currentDate,
                      ),
                  ),
                ),
                const Expanded(
                  child: ExpensesList(),
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
              label: "Home",
            ),
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
      builder: (ctx) => const NewExpense(),
    );
  }
}

// import 'package:expense_tracker/database/models/expense.dart';
// import 'package:expense_tracker/providers/theme_provider.dart';
// import 'package:expense_tracker/screens/settings_sc.dart';
// import 'package:expense_tracker/widgets/chart/chart.dart';
// import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
// import 'package:expense_tracker/widgets/expenses/new_expense.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class ExpensesScreen extends StatefulWidget {
//   static const String routeName = "expenses_screen";
//
//   const ExpensesScreen({super.key});
//
//   @override
//   State<ExpensesScreen> createState() => _ExpensesScreenState();
// }
//
// class _ExpensesScreenState extends State<ExpensesScreen> {
//   final List<Expense> _registeredExpenses = [];
//   int tabIndex = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
//     Widget pageContent = const Center(
//       child: Text(
//           "Looks like you don't have any expenses.",
//       ),
//     );
//     if (_registeredExpenses.isNotEmpty) {
//       pageContent = ExpensesList(
//         expenses: _registeredExpenses,
//         onRemoveExpense: _removeExpense,
//       );
//     }
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _openAddExpenseOverlay();
//         },
//         child: const Icon(
//           Icons.add_box_rounded,
//           size: 25,
//         ),
//       ),
//       bottomNavigationBar: bottomAppBar(),
//       appBar: tabIndex == 0
//           ? AppBar(
//               title: SvgPicture.asset(
//                   "assets/icons/logo_white.svg",
//                 width: 190,
//               )
//             )
//           : AppBar(
//               actions: [
//                 IconButton(
//                     onPressed: () {
//                         themeProvider.toggleTheme();
//                     },
//                     icon: themeProvider.isDark() == true
//                         ? const Icon(
//                       Icons.light_mode_rounded,
//                       size: 25,
//                       color: Colors.yellow,
//                     )
//                         : const Icon(
//                       Icons.dark_mode_rounded,
//                       size: 25,
//                       color: Colors.black,
//                     ),
//                 ),
//               ],
//               title: const Text(
//                   "Settings",
//                 style: TextStyle(
//                     fontFamily: "Lato",
//                     fontWeight: FontWeight.bold
//                 ),
//               ),
//             ),
//       body: tabIndex == 0
//           ? Column(
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: Chart(_registeredExpenses),
//                 ),
//                 Expanded(
//                   child: pageContent,
//                 ),
//               ],
//             )
//           : const SettingsScreen(),
//     );
//   }
//
//   BottomAppBar bottomAppBar() {
//     return BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       clipBehavior: Clip.hardEdge,
//       notchMargin: 8,
//       child: BottomNavigationBar(
//         unselectedItemColor: Colors.white,
//           currentIndex: tabIndex,
//           onTap: (value) {
//             setState(() {
//               tabIndex = value;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home_outlined),
//                 activeIcon: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.home_outlined),
//                 ),
//                 label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               activeIcon: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.settings),
//               ),
//               label: "Settings",
//             )
//           ]),
//     );
//   }
//
//   void _openAddExpenseOverlay() {
//     showModalBottomSheet(
//       useSafeArea: true,
//       enableDrag: true,
//       isScrollControlled: true,
//       showDragHandle: true,
//       context: context,
//       builder: (ctx) => NewExpense(onAddExpense: _addExpense),
//     );
//   }
//
//   void _addExpense(Expense expense) {
//     setState(() {
//       _registeredExpenses.add(expense);
//     });
//   }
//
//   void _removeExpense(Expense expense) {
//     final removedExpenseIndex = _registeredExpenses.indexOf(expense);
//     setState(() {
//       _registeredExpenses.remove(expense);
//     });
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 4),
//         content: const Text("Expense deleted"),
//         action: SnackBarAction(
//           label: "Undo",
//           onPressed: () {
//             setState(() {
//               _registeredExpenses.insert(removedExpenseIndex, expense);
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
