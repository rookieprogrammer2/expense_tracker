import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final dateFormatter = DateFormat.yMd();

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
   String? id;
   String? title;
   double? amount;
   Category? category;
   DateTime? date;
   bool? isDeleted;


  Expense({
    this.id,
    this.title,
    this.amount,
    this.category,
    this.date,
    this.isDeleted = false
  });
   String get formattedDate {
    return dateFormatter.format(date!);
  }
  Expense.fromFirestore (Map<String, dynamic>? data) {
    id = data?['id'];
    title = data?['title'];
    amount = data?['amount'];
    Timestamp dateTMSTMP = data?["date"];
    date = dateTMSTMP.toDate();
    isDeleted = data?['isDeleted'];
    category = Category.values.firstWhere(
          (cat) => cat.toString() == 'Category.${data?['category']}',
    );
  }
  Map<String, dynamic> toFirestore () {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'isDeleted': isDeleted,
      'category': category?.toString().split('.')[1],
    };
  }
}

class ExpenseBucket {

  final Category category;
  final List<Expense> _expenses;

  double get totalExpenses {
    double sum = 0;

    for(final expense in _expenses) {
      sum += expense.amount!;
    }
    return sum;
  }

  ExpenseBucket.forCategory (List<Expense> registeredExpenses, this.category) :
        _expenses = registeredExpenses.where((expense) => expense.category == category).toList();


}


