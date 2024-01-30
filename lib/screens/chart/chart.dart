// import 'package:expense_tracker/providers/theme_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:expense_tracker/screens/chart/chart_bar.dart';
// import 'package:expense_tracker/database/models/expense.dart';
// import 'package:provider/provider.dart';
//
// class Chart extends StatelessWidget {
//   const Chart(this._registeredExpenses, {super.key});
//
//   final List<Expense> _registeredExpenses;
//
//   List<ExpenseBucket> get buckets {
//     return [
//       ExpenseBucket.forCategory(_registeredExpenses, Category.essentials),
//       ExpenseBucket.forCategory(_registeredExpenses, Category.leisure),
//       ExpenseBucket.forCategory(_registeredExpenses, Category.travelling),
//       ExpenseBucket.forCategory(_registeredExpenses, Category.payments),
//       ExpenseBucket.forCategory(_registeredExpenses, Category.bills),
//       ExpenseBucket.forCategory(_registeredExpenses, Category.learning),
//     ];
//   }
//
//   double get maxTotalExpense {
//     double maxTotalExpense = 0;
//
//     for (final bucket in buckets) {
//       if (bucket.totalExpenses > maxTotalExpense) {
//         maxTotalExpense = bucket.totalExpenses;
//       }
//     }
//     return maxTotalExpense;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//       width: double.infinity,
//       height: 180,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         gradient: LinearGradient(
//           colors: [
//             Theme.of(context).colorScheme.primary.withOpacity(0.3),
//             Theme.of(context).colorScheme.primary.withOpacity(0.0)
//           ],
//           begin: Alignment.bottomCenter,
//           end: Alignment.topCenter,
//         ),
//       ),
//       child: Column(
//         children: [
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 for (final bucket in buckets)
//                   ChartBar(
//                     fill: bucket.totalExpenses == 0
//                         ? 0
//                         : bucket.totalExpenses / maxTotalExpense,
//                   )
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: buckets
//                 .map(
//                   (bucket) => Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: Icon(
//                     categoryIcons[bucket.category],
//                     color: Provider.of<ThemeProvider>(context).isDark() == true
//                         ? Colors.white
//                         : const Color.fromARGB(255, 53, 74, 83),
//                   ),
//                 ),
//               ),
//             ).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:expense_tracker/database/expense_dao.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/screens/chart/chart_bar.dart';
import 'package:expense_tracker/database/models/expense_model.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  final Stream<List<Expense>> expensesStream;
  const Chart({required this.expensesStream, super.key});


  List<ExpenseBucket> getBuckets(List<Expense> registeredExpenses) {
    return [
      ExpenseBucket.forCategory(registeredExpenses, Category.essentials),
      ExpenseBucket.forCategory(registeredExpenses, Category.leisure),
      ExpenseBucket.forCategory(registeredExpenses, Category.travelling),
      ExpenseBucket.forCategory(registeredExpenses, Category.payments),
      ExpenseBucket.forCategory(registeredExpenses, Category.bills),
      ExpenseBucket.forCategory(registeredExpenses, Category.learning),
    ];
  }

  double getMaxTotalExpense(List<ExpenseBucket> buckets) {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Expense>>(
        stream: expensesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}'
                )
            );
          }
          final registeredExpenses = snapshot.data ?? [];
          final buckets = getBuckets(registeredExpenses);
          final maxTotalExpense = getMaxTotalExpense(buckets);

          return Container(
            margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                    Theme.of(context).colorScheme.primary.withOpacity(0.0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final bucket in buckets)
                          ChartBar(
                            fill: bucket.totalExpenses == 0
                                ? 0
                                : bucket.totalExpenses / maxTotalExpense,
                          )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: buckets
                        .map(
                          (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[bucket.category],
                            color: Provider.of<ThemeProvider>(context).isDark()
                                ? Colors.white
                                : const Color.fromARGB(255, 53, 74, 83),
                          ),
                        ),
                      ),
                    ).toList(),
                  ),
                ],
              ),
          );
        }
        );
  }
}


    //   Container(
    //   margin: const EdgeInsets.all(16),
    //   padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    //   width: double.infinity,
    //   height: 180,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(25),
    //     gradient: LinearGradient(
    //       colors: [
    //         Theme.of(context).colorScheme.primary.withOpacity(0.3),
    //         Theme.of(context).colorScheme.primary.withOpacity(0.0)
    //       ],
    //       begin: Alignment.bottomCenter,
    //       end: Alignment.topCenter,
    //     ),
    //   ),
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           children: [
    //             for (final bucket in buckets)
    //               ChartBar(
    //                 fill: bucket.totalExpenses == 0
    //                     ? 0
    //                     : bucket.totalExpenses / maxTotalExpense,
    //               )
    //           ],
    //         ),
    //       ),
    //       const SizedBox(height: 12),
    //       Row(
    //         children: buckets
    //             .map(
    //               (bucket) => Expanded(
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 4),
    //               child: Icon(
    //                 categoryIcons[bucket.category],
    //                 color: Provider.of<ThemeProvider>(context).isDark()
    //                     ? Colors.white
    //                     : const Color.fromARGB(255, 53, 74, 83),
    //               ),
    //             ),
    //           ),
    //         ).toList(),
    //       ),
    //     ],
    //   ),
    // );

