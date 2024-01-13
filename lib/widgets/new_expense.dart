import 'package:flutter/material.dart';
class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: const InputDecoration(
                prefix: Icon(Icons.attach_money_rounded),
                label: Text("Amount"),
              ),
            ),
          ),
              const SizedBox(width: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Selected Date Placeholder"),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month)),
                ],
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: (){},
                  child: const Text("Add Expense"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
