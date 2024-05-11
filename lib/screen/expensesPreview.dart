import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style/appStyle.dart';

class Expense {
  final DateTime date;
  final String location;
  final double lodgingAmount;
  final double mealAmount;
  final double othersAmount;
  final String description;

  Expense({
    required this.date,
    required this.location,
    required this.lodgingAmount,
    required this.mealAmount,
    required this.othersAmount,
    required this.description,
  });
}

class ExpensePreview extends StatelessWidget {
  final List<Expense> expenses;

  ExpensePreview({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Preview',
          style: TextStyle(color: kthirdColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text('S.No.')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Location')),
            DataColumn(label: Text('Total Expenses')),
          ],
          rows: expenses.asMap().entries.map((entry) {
            final index = entry.key + 1;
            final expense = entry.value;
            double totalExpenses = expense.lodgingAmount +
                expense.mealAmount +
                expense.othersAmount;
            return DataRow(
              selected: false,
              cells: [
                DataCell(Text('$index')),
                DataCell(
                    Text('${DateFormat('dd/MM/yyyy').format(expense.date)}')),
                DataCell(Text(expense.location)),
                DataCell(Text('\₹$totalExpenses')),
              ],
              onSelectChanged: (selected) {
                if (selected!) {
                  _showDetailsDialog(context, expense);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, Expense expense) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Expense Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Date: ${DateFormat('dd/MM/yyyy').format(expense.date)}'),
                Text('Location: ${expense.location}'),
                Text('Description: ${expense.description}'),
                Text('Lodging Amount: \₹${expense.lodgingAmount}'),
                Text('Meal Amount: \₹${expense.mealAmount}'),
                Text('Other Amount: \₹${expense.othersAmount}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
