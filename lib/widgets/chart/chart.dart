import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/database/models/expense.dart';
import 'package:provider/provider.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.registeredExpenses});

  final List<Expense> registeredExpenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(registeredExpenses, Category.essentials, "Essentials"),
      ExpenseBucket.forCategory(registeredExpenses, Category.leisure, "Leisure"),
      ExpenseBucket.forCategory(registeredExpenses, Category.travelling, "Travelling"),
      ExpenseBucket.forCategory(registeredExpenses, Category.payments, "Payments"),
      ExpenseBucket.forCategory(registeredExpenses, Category.bills, "Bills"),
      ExpenseBucket.forCategory(registeredExpenses, Category.learning, "Learning"),
    ];
  }

  double get maxTotalExpense {
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
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
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
                    color: Provider.of<ThemeProvider>(context).isDark() == false
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
}