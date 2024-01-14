// import 'package:cloud_firestore/cloud_firestore.dart';
//
// enum Category {essentials, travelling, leisure, bills, payments, learning}
//
// class Expense {
//    String? id;
//    String? title;
//    double? amount;
//    // DateTime? date;
//    Category? category;
//    Timestamp? dateTime;
//    bool isDeleted;
//
//
//   Expense({
//     this.id,
//     this.title,
//     this.amount,
//     this.category,
//     this.dateTime,
//     this.isDeleted = false
//   });
//   Expense.fromFirestore (Map<String, dynamic>? data) {
//     id = data?['id'];
//     title = data?['title'];
//     amount = data?['amount'];
//     category = data?['category'];
//     dateTime = data?['date'];
//     questions = data?['questions'];
//   }
//   Map<String, dynamic> toFirestore () {
//     return {
//       'id': id,
//       'title': title,
//       'date': date,
//       'questions': questions
//     };
//   }
// }
//
//
// class Question {
//   String text;
//   bool isTrueFalse;
//   List<String> options;
//   int correctOptionIndex;
//
//   Question({
//     required this.text,
//     required this.isTrueFalse,
//     required this.options,
//     required this.correctOptionIndex,
//   });
// }
//
