import 'package:expense_tracker/database/models/expense.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewExpense extends StatefulWidget {
  final void Function(Expense expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _expenseTitleController = TextEditingController();
  final _expenseAmountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  Category _selectedCategory = Category.leisure;

  void _showDatePicker() async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(
            DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime.now());
    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_expenseAmountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount == 0;
    if (_expenseTitleController.text.trim().isEmpty || amountIsInvalid) {
      MyDialogs.showCustomDialog(
        context,
        dialogMessage: "Please enter a valid title and/or amount",
        isDismissible: true,
        title: const Text(
          "Invalid input",
          style: TextStyle(fontFamily: "Lato", fontWeight: FontWeight.w500),
        ),
        positiveActionName: "Okay",
      );
      return;
    } else {
      widget.onAddExpense(
        Expense(
            title: _expenseTitleController.text,
            date: _selectedDate,
            amount: enteredAmount,
            category: _selectedCategory),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _expenseTitleController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
      child: Provider.of<ThemeProvider>(context).isDark() == false
          ? lightModeNewExpenseOverlay(context)
          : darkModeNewExpenseOverlay(context),
    );
  }

  Column darkModeNewExpenseOverlay(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _expenseTitleController,
          maxLength: 15,
          decoration: InputDecoration(
            label: const Text(
              "Title",
              style: TextStyle(
                fontFamily: "Lato",
                color: Colors.white,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _expenseAmountController,
                decoration: InputDecoration(
                  prefixText: "EGP \$ ",
                  label: const Text(
                    "Amount",
                    style: TextStyle(
                      fontFamily: "Lato",
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  dateFormatter.format(_selectedDate),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DropdownButton(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (category) {
                  if (category == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = category;
                  });
                }),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitExpenseData,
              child: const Text(
                "Add Expense",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column lightModeNewExpenseOverlay(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _expenseTitleController,
          maxLength: 15,
          decoration: InputDecoration(
            label: const Text(
              "Title",
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _expenseAmountController,
                decoration: InputDecoration(
                  prefixText: "EGP \$ ",
                  label: const Text(
                      "Amount",
                    style:
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lato",
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  dateFormatter.format(_selectedDate),
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _showDatePicker();
                  },
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DropdownButton(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: "Lato",
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (category) {
                  if (category == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = category;
                  });
                }),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style:
                    TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: "Lato",
                    ),
              ),
            ),
            ElevatedButton(
              onPressed: _submitExpenseData,
              child: const Text(
                "Add Expense",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Lato",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
