import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
import '../model/expense.dart';

class ExpenseListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expenses')),
      body: StreamBuilder<List<Expense>>(
        stream: getExpensesFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final expenses = snapshot.data ?? [];
          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ListTile(
                title: Text(expense.category),
                subtitle: Text('Amount: \$${expense.amount}'),
                trailing: Text(expense.date.toLocal().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
