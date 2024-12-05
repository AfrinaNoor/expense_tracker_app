// lib/screens/add_expense_screen.dart
import 'package:flutter/material.dart';
import '../model/expense.dart';
import '../services/firebase_service.dart'; // Import the Firebase service function

class AddExpenseScreen extends StatelessWidget {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () {
                String category = _categoryController.text;
                double amount = double.tryParse(_amountController.text) ?? 0.0;
                String description = _descriptionController.text;

                // Create an Expense object
                Expense expense = Expense(
                  id: '',  // Firebase will generate the ID
                  category: category,
                  amount: amount,
                  description: description,
                  date: DateTime.now(),
                );

                // Send the expense to Firebase
                addExpenseToFirebase(expense);

                // Clear the input fields
                _categoryController.clear();
                _amountController.clear();
                _descriptionController.clear();

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Expense Added')));
              },
              child: Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
