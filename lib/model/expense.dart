import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final formatter = DateFormat.yMd();

final uuid = Uuid();

enum Catagory { food, travel, leisure, work }

const catagoryIcons = {
  Catagory.food: Icons.lunch_dining,
  Catagory.travel: Icons.flight_takeoff,
  Catagory.leisure: Icons.movie,
  Catagory.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.catagory,
  }) : id = uuid.v4();
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Catagory catagory;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.catagory == category)
            .toList();

  final Catagory category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}

// class ExpenseBucket {
//   const ExpenseBucket({required this.catagory, required this.expenses});

//   ExpenseBucket.forcategory(
//     List<Expense> allExpenses,
//     this.catagory,
//   ) : expenses = allExpenses
//             .where((expense) => expense.catagory == catagory)
//             .toList();

//   final Catagory catagory;
//   final List<Expense> expenses;

//   double get totalExpenses {
//     double sum = 0;
//     for (final expense in expenses) {
//       sum = sum + expense.amount;
//     }
//     return sum;
//   }
// }
