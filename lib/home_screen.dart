import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_expense_screen.dart';
import 'transaction_history_screen.dart';
import 'categories_screen.dart';
import 'budgeting_screen.dart';
import 'reports_screen.dart';
import 'savings_screen.dart';
import 'settings_screen.dart';
import 'theme_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Determine the primary background and text colors
    Color primaryTextColor = themeProvider.isDarkMode ? Colors.white : Colors.black;
    Color primaryBackgroundColor = themeProvider.isDarkMode ? Colors.black : Colors.white;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent.shade400, Colors.purpleAccent.shade100], // Green and Blue gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Home',
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 1.2,
          ),
        ),
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? Colors.black : Colors.white,
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
              color: themeProvider.isDarkMode ? Colors.black : Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: themeProvider.isDarkMode ? Colors.black : Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),

      // Drawer with dynamic colors
      drawer: Drawer(
        child: Container(
          color: primaryBackgroundColor, // Drawer background color
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent.shade400, Colors.purple.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'FinTrack',
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildDrawerItem(
                context,
                'Home',
                Icons.home,
                primaryTextColor,
                null,
              ),
              _buildDrawerItem(
                context,
                'Add Expense',
                Icons.add,
                primaryTextColor,
                AddExpenseScreen(),
              ),
              _buildDrawerItem(
                context,
                'Transaction History',
                Icons.history,
                primaryTextColor,
                TransactionHistoryScreen(),
              ),
              _buildDrawerItem(
                context,
                'Categories',
                Icons.category,
                primaryTextColor,
                CategoriesScreen(),
              ),
              _buildDrawerItem(
                context,
                'Budgeting',
                Icons.attach_money,
                primaryTextColor,
                BudgetingScreen(),
              ),
              _buildDrawerItem(
                context,
                'Savings', // Add the new Savings Screen here
                Icons.savings_outlined,
                primaryTextColor,
                SavingsScreen(),
              ),
              _buildDrawerItem(
                context,
                'Reports',
                Icons.pie_chart,
                primaryTextColor,
                ReportsScreen(),
              ),
              _buildDrawerItem(
                context,
                'Settings',
                Icons.settings,
                primaryTextColor,
                SettingsScreen(),
              ),
            ],
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          color: primaryBackgroundColor, // Body background color
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.pink : Colors.deepPurple,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),

              // Colorful Quick Action Cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildQuickActionCard(
                    context,
                    'Add Expense',
                    Icons.add,
                    Colors.pink.shade400,
                    AddExpenseScreen(),
                    primaryTextColor,
                  ),
                  _buildQuickActionCard(
                    context,
                    'History',
                    Icons.history,
                    Colors.orange.shade400,
                    TransactionHistoryScreen(),
                    primaryTextColor,
                  ),
                  _buildQuickActionCard(
                    context,
                    'Budgeting',
                    Icons.attach_money,
                    Colors.teal.shade400,
                    BudgetingScreen(),
                    primaryTextColor,
                  ),
                ],
              ),
              SizedBox(height: 30),

              Text(
                'Expense Summary',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.pink : Colors.deepPurple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Color-coded summary cards
              _buildSummaryCard('Total Expenses', '\$500.00', Icons.monetization_on,
                  themeProvider.isDarkMode ? Colors.red.shade500 : Colors.redAccent.shade200, primaryTextColor),
              SizedBox(height: 10),
              _buildSummaryCard('Remaining Balance', '\$200.00', Icons.savings, themeProvider.isDarkMode ? Colors.green.shade500 : Colors.lightGreenAccent, primaryTextColor),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFinancialTip(context, themeProvider);
        },
        backgroundColor: themeProvider.isDarkMode ? Colors.pink : Colors.purple,
        child: Icon(Icons.lightbulb, color: themeProvider.isDarkMode ? Colors.black : Colors.white),
        tooltip: 'Daily Insight',
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, Color textColor, Widget? targetScreen) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      onTap: () {
        if (targetScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        } else {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget _buildQuickActionCard(
      BuildContext context,
      String title,
      IconData icon,
      Color iconColor,
      Widget targetScreen,
      Color textColor,
      ) {
    return Card(
      color: Colors.yellowAccent[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        },
        child: Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 40),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String amount, IconData icon, Color cardColor, Color textColor) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white, size: 30), // Larger icon size
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 22, // Larger font size for title
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
        subtitle: Text(
          amount,
          style: TextStyle(
            color: textColor,
            fontSize: 20, // Larger font size for amount
            fontWeight: FontWeight.bold, // Bold text
          ),
        ),
      ),
    );
  }
}

  void _showFinancialTip(BuildContext context, ThemeProvider themeProvider) {
    final tips = [
      "Track your expenses daily to avoid overspending.",
      "Save at least 20% of your monthly income.",
      "Avoid impulsive purchases by following the 24-hour rule.",
      "Set financial goals and review them weekly.",
      "Cook at home to save money on dining out.",
    ];
    final randomTip = (tips..shuffle()).first;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Financial Tip',
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.pink : Colors.purpleAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: themeProvider . isDarkMode ? Colors.pink : Colors.purpleAccent),
                    onPressed: () {
                      Navigator.pop(context); // Close the BottomSheet
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                randomTip,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
