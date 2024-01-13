import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work}


const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.gamepad,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff
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