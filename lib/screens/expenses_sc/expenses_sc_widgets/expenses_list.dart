import 'package:expense_tracker/database/expense_dao.dart';
import 'package:expense_tracker/database/models/expense_model.dart';
import 'package:expense_tracker/providers/date_provider.dart';
import 'package:expense_tracker/screens/expenses_sc/expenses_sc_widgets/expense_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({super.key});

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Expense>>(
      stream: ExpenseDAO.listenToExpensesByMonth(
              FirebaseAuth.instance.currentUser!.uid,
              Provider.of<DateProvider>(context).currentDate,
            ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Column(
              children: [
                Text(
                  "Something went wrong. Please try again.",
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ],
            ),
          );
        } else {
          var expensesList = snapshot.data ?? [];
          if (expensesList.isEmpty) {
            return const Center(
              child: Text(
                "Looks like you don't have any expenses.",
                style: TextStyle(
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: expensesList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(expensesList[index]),
                onDismissed: (direction) => removeExpense(expensesList[index]),
                direction: DismissDirection.startToEnd,
                resizeDuration: const Duration(seconds: 2),
                background: Container(
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.symmetric(
                      horizontal:
                          Theme.of(context).cardTheme.margin!.horizontal,
                      vertical: 9),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.delete),
                      Text("Delete"),
                    ],
                  ),
                ),
                child: ExpenseItem(
                  expense: expensesList[index],
                ),
              );
            },
          );
        }
      },
    );
  }

  void removeExpense(Expense expense) async {
    await ExpenseDAO.deleteExpense(
        expense.id!, FirebaseAuth.instance.currentUser!.uid);
  }
}

// Widget build(BuildContext context) {
//   return StreamBuilder(
//     stream: ExpenseDAO.listenToExpenses(FirebaseAuth.instance.currentUser!.uid),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: Text("Looks like you haven't made any expenses."),
//         );
//       }
//       if (snapshot.hasError) {
//         return Center(
//           child: Column(
//             children: [
//               const Text(
//                 "Something went wrong. Please try again.",
//               ),
//               ElevatedButton(
//                 onPressed: (){
//
//                 }, child: const Text(
//                 "Try again",
//               ),
//               ),
//             ],
//           ),
//         );
//
//       } else {
//         var expensesList = snapshot.data;
//         return ListView.builder(
//           itemCount: expensesList?.length ?? 0,
//           itemBuilder: (context, index) {
//             return ExpenseItem(expense: expensesList![index], onDelete: removeExpense);
//           },
//
//         );
//
//       }
//     },
//   );
// }

// import 'package:expense_tracker/database/models/expense.dart';
// import 'package:expense_tracker/screens/expenses/expensesWidgets/expense_item.dart';
// import 'package:flutter/material.dart';
//
// class ExpensesList extends StatelessWidget {
//   final List<Expense> expenses;
//   final void Function(Expense expense) onRemoveExpense;
//
//   const ExpensesList(
//       {super.key, required this.expenses, required this.onRemoveExpense});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: expenses.length,
//       itemBuilder: (context, index) {
//         return Dismissible(
//             direction: DismissDirection.startToEnd,
//             resizeDuration: const Duration(seconds: 2),
//             background: Container(
//               decoration: BoxDecoration(
//                   color: Colors.red, borderRadius: BorderRadius.circular(15)),
//               margin: EdgeInsets.symmetric(
//                   horizontal: Theme.of(context).cardTheme.margin!.horizontal,
//                   vertical: 9),
//               child: const Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Icon(Icons.delete),
//                   Text("Delete"),
//                 ],
//               ),
//             ),
//             key: ValueKey(expenses[index]),
//             onDismissed: (direction) => onRemoveExpense(expenses[index]),
//             child: ExpenseItem(expense: expenses[index]));
//       },
//     );
//   }
// }
