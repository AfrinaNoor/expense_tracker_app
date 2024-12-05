import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  String selectedDateFilter = 'Today';
  String selectedCategoryFilter = 'All';
  String searchQuery = '';
  final List<Map<String, dynamic>> transactions = [
    {'title': 'Groceries', 'category': 'Food', 'amount': -50.0},
    {'title': 'Bus Fare', 'category': 'Transport', 'amount': -10.0},
    {'title': 'Movie Ticket', 'category': 'Entertainment', 'amount': -20.0},
    {'title': 'Salary', 'category': 'Income', 'amount': 1000.0},
    {'title': 'Doctor Bill', 'category': 'Health', 'amount': -100.0},
  ];

  @override
  Widget build(BuildContext context) {
    // Determine the AppBar text color based on the theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transaction History',
          style: TextStyle(
            fontSize: 22.0,
            color: appBarTextColor, // Dynamically set text color
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Date filter options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDateFilterButton('Today'),
                  _buildDateFilterButton('Last Week'),
                  _buildDateFilterButton('Last Month'),
                ],
              ),
            ),
          ),
          // Category filter options
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryFilterButton('All'),
                  _buildCategoryFilterButton('Food'),
                  _buildCategoryFilterButton('Transport'),
                  _buildCategoryFilterButton('Entertainment'),
                  _buildCategoryFilterButton('Health'),
                ],
              ),
            ),
          ),
          // Search bar for searching transactions
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Transactions',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // ListView of transactions
          Expanded(
            child: ListView.builder(
              itemCount: transactions
                  .where((transaction) =>
              transaction['title']
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) &&
                  (selectedCategoryFilter == 'All' ||
                      transaction['category'] == selectedCategoryFilter))
                  .toList()
                  .length,
              itemBuilder: (context, index) {
                var transaction = transactions
                    .where((transaction) =>
                transaction['title']
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) &&
                    (selectedCategoryFilter == 'All' ||
                        transaction['category'] == selectedCategoryFilter))
                    .toList()[index];

                return Dismissible(
                  key: Key(transaction['title']),
                  onDismissed: (direction) {
                    setState(() {
                      transactions.remove(transaction);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${transaction['title']} deleted")));
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text(transaction['title']),
                    subtitle: Text(transaction['category']),
                    trailing: Text('${transaction['amount']}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Button to select date filter
  Widget _buildDateFilterButton(String period) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDateFilter = period;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Chip(
          label: Text(period),
          backgroundColor:
          selectedDateFilter == period ? Colors.purple : Colors.grey.shade200,
          labelStyle: TextStyle(
            color: selectedDateFilter == period ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // Button to select category filter
  Widget _buildCategoryFilterButton(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryFilter = category;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Chip(
          label: Text(category),
          backgroundColor:
          selectedCategoryFilter == category ? Colors.purple : Colors.grey.shade200,
          labelStyle: TextStyle(
            color: selectedCategoryFilter == category ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
