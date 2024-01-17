import 'package:cloud_firestore/cloud_firestore.dart';

enum Category {essentials, travelling, leisure, bills, payments, learning}

class Expense {
   String? id;
   String? title;
   double? amount;
   // DateTime? date;
   Category? category;
   Timestamp? timestamp;
   bool? isDeleted;


  Expense({
    this.id,
    this.title,
    this.amount,
    this.category,
    this.timestamp,
    this.isDeleted = false
  });
  Expense.fromFirestore (Map<String, dynamic>? data) {
    id = data?['id'];
    title = data?['title'];
    amount = data?['amount'];
    timestamp = data?['date'];
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
      'date': timestamp,
      'isDeleted': isDeleted,
      'category': category?.toString().split('.')[1],
    };
  }
}


