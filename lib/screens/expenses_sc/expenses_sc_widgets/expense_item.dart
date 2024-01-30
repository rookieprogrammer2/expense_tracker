import 'package:expense_tracker/database/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatefulWidget {
  final Expense expense;
  const ExpenseItem({required this.expense, super.key});

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(categoryIcons[widget.expense.category]),
                const SizedBox(width: 4),
                Text(
                    widget.expense.title!,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    )
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'EGP ${widget.expense.amount?.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),),
                const Spacer(),
                Text(
                  widget.expense.formattedDate,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}









// import 'package:expense_tracker/database/models/expense.dart';
// import 'package:flutter/material.dart';
//
// class ExpenseItem extends StatelessWidget {
//   final Expense expense;
//   const ExpenseItem({required this.expense, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 16,
//           ),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Icon(categoryIcons[expense.category]),
//                   const SizedBox(width: 4,),
//                   Text(
//                       expense.title,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500
//                       )
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   Text(
//                       'EGP\$ ${expense.amount.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),),
//                   const Spacer(),
//                   Text(
//                     expense.formattedDate,
//                     style: const TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//   }
// }