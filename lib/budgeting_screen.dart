import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BudgetingScreen extends StatefulWidget {
  @override
  _BudgetingScreenState createState() => _BudgetingScreenState();
}

class _BudgetingScreenState extends State<BudgetingScreen> {
  double _budgetLimit = 500.0;
  double _spentAmount = 120.0; // Example spent amount
  double _remainingAmount = 500.0 - 120.0;

  @override
  Widget build(BuildContext context) {
    // Determine the AppBar text color based on the theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Set Budget',
          style: TextStyle(
            fontSize: 22.0,
            color: appBarTextColor, // Dynamically set text color
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Monthly budget display with progress
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Budget: \$$_budgetLimit',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Remaining: \$$_remainingAmount',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Circular progress indicator
            Container(
              height: 150,
              width: 150,
              child: CircularProgressIndicator(
                value: _spentAmount / _budgetLimit,
                strokeWidth: 10,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
              ),
            ),
            SizedBox(height: 20),

            // Budget limit slider
            Slider(
              value: _budgetLimit,
              min: 100,
              max: 1000,
              onChanged: (value) {
                setState(() {
                  _budgetLimit = value;
                  _remainingAmount = _budgetLimit - _spentAmount;
                });
              },
            ),
            SizedBox(height: 20),

            // Example: Budget category breakdown (could be expanded for multiple categories)
            Text(
              'Set Category Budgets',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            _buildCategoryBudget('Food', 150),
            _buildCategoryBudget('Transport', 100),
            _buildCategoryBudget('Entertainment', 80),

            SizedBox(height: 30),

            // Save button
            ElevatedButton(
              onPressed: () {
                // Save budget limit
                // Logic to save the budget limit
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Budget Saved"),
                      content: Text("Your budget has been saved successfully."),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Save Budget'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to display category-wise budget
  Widget _buildCategoryBudget(String category, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(category, style: TextStyle(fontSize: 16)),
          Text('\$${amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
