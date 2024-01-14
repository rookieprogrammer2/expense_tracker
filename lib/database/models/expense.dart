import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {essentials, travelling, leisure, bills, payments, learning}

const categoryIcons = {
  Category.essentials: Icons.shopping_bag,
  Category.leisure: Icons.fastfood_rounded,
  Category.learning: Icons.menu_book_rounded,
  Category.travelling: Icons.flight_takeoff,
  Category.bills: Icons.receipt_rounded,
  Category.payments: Icons.credit_card
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.date,
    required this.amount,
    required this.category
  }) : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

// A class for the total expenses occurred pertaining to a specific category.
// It is a bucket full of expenses of a certain category, in other words.
// The "expenses" field represents all the expenses.
// The "category" field represents the category where all those expenses came from.
class ExpenseBucket {

  final Category category;
  final List<Expense> expenses;

  ExpenseBucket ({required this.category, required this.expenses});

  // The following is a getter that returns the sum of all the expenses occurred
  double get totalExpenses {
    double sum = 0;

    for(final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

  ExpenseBucket.forCategory (List<Expense> allExpenses, this.category) :
        expenses = allExpenses.where((expense) => expense.category == category).toList();



}
