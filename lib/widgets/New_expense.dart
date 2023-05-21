import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddexpense});

  final void Function(Expense expense) onAddexpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  Catagory selectedCatagory = Catagory.leisure;
  DateTime? selectedDate;

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      selectedDate = pickedDate;
    });
  }

  submitExpenseData() {
    final enterdAmount = double.tryParse(amountController.text);
    final amountIsInvalid = enterdAmount == null || enterdAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('ohk!!!'))
          ],
          content: Text('Please enter valid data'),
          title: Text('Invalid Input'),
        ),
      );
      return;
    }
    widget.onAddexpense(
      Expense(
          title: titleController.text,
          amount: enterdAmount,
          date: selectedDate!,
          catagory: selectedCatagory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, contraints) {
        final width = contraints.maxWidth;
        return SizedBox(
          height: double.infinity, //for full screen ModelWidget
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: titleController,
                            maxLength: 50,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefix: Text('₹  '),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: titleController,
                      maxLength: 50,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: selectedCatagory,
                          items: Catagory.values
                              .map(
                                (catagory) => DropdownMenuItem(
                                  value: catagory,
                                  child: Text(
                                    catagory.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              selectedCatagory = value;
                            });
                          },
                        ),
                        SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(selectedDate!),
                              ),
                              IconButton(
                                onPressed: presentDatePicker,
                                icon: Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefix: Text('₹  '),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(selectedDate!),
                              ),
                              IconButton(
                                onPressed: presentDatePicker,
                                icon: Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('cancle'),
                        ),
                        ElevatedButton(
                          onPressed: submitExpenseData,
                          child: Text('Save'),
                        )
                      ],
                    )
                  else
                    // SizedBox(
                    //   height: 16,
                    // ),
                    Row(
                      children: [
                        DropdownButton(
                          value: selectedCatagory,
                          items: Catagory.values
                              .map(
                                (catagory) => DropdownMenuItem(
                                  value: catagory,
                                  child: Text(
                                    catagory.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              selectedCatagory = value;
                            });
                          },
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('cancle'),
                        ),
                        ElevatedButton(
                          onPressed: submitExpenseData,
                          child: Text('Save'),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
