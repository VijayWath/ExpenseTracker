import 'package:expense_tracker/widgets/Expenses_list.dart/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/New_expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

List<Expense> registerdExpenses = [
  Expense(
      title: 'momos',
      amount: 69,
      date: DateTime.now(),
      catagory: Catagory.food),
  Expense(
      title: 'course',
      amount: 80,
      date: DateTime.now(),
      catagory: Catagory.travel),
];

class _ExpensesState extends State<Expenses> {
  void openAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddexpense: addExpense),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      registerdExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = registerdExpenses.indexOf(expense);

    setState(
      () {
        registerdExpenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              registerdExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('Spend Some Money'),
    );

    if (registerdExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          onRemoveExpense: removeExpense, expenses: registerdExpenses);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [
            IconButton(
              onPressed: () {
                openAddExpenseOverlay(context);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: registerdExpenses),
                  Expanded(child: mainContent)
                ],
              )
            : Row(
                children: [
                  Expanded(child: Chart(expenses: registerdExpenses)),
                  Expanded(child: mainContent)
                ],
              ));
  }
}
