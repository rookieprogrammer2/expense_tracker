// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Quiz {
//   String? id;
//   String? title;
//   Timestamp? date;
//   List<Question>? questions;
//
//   Quiz({
//     required this.id,
//     required this.title,
//     required this.date,
//     required this.questions,
//   });
//   Quiz.fromFirestore (Map<String, dynamic>? data) {
//     id = data?['id'];
//     title = data?['title'];
//     date = data?['date'];
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
