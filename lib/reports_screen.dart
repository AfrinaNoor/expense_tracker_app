import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // For PieChart

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedPeriod = 'Daily';

  // Sample data for PieChart with updated category colors
  final Map<String, List<PieChartSectionData>> reportData = {
    'Daily': [
      PieChartSectionData(value: 30, color: Colors.orange, title: ''),
      PieChartSectionData(value: 20, color: Colors.blue, title: ''),
      PieChartSectionData(value: 20, color: Colors.red, title: ''),
      PieChartSectionData(value: 30, color: Colors.pink, title: ''),
    ],
    'Weekly': [
      PieChartSectionData(value: 25, color: Colors.green, title: ''),
      PieChartSectionData(value: 35, color: Colors.blue, title: ''),
      PieChartSectionData(value: 15, color: Colors.purple, title: ''),
      PieChartSectionData(value: 25, color: Colors.teal, title: ''),
    ],
    'Monthly': [
      PieChartSectionData(value: 15, color: Colors.green, title: ''),
      PieChartSectionData(value: 45, color: Colors.blue, title: ''),
      PieChartSectionData(value: 20, color: Colors.cyan, title: ''),
      PieChartSectionData(value: 20, color: Colors.brown, title: ''),
    ],
    'Yearly': [
      PieChartSectionData(value: 10, color: Colors.grey, title: ''),
      PieChartSectionData(value: 20, color: Colors.green, title: ''),
      PieChartSectionData(value: 40, color: Colors.blue, title: ''),
      PieChartSectionData(value: 30, color: Colors.red, title: ''),
      PieChartSectionData(value: 5, color: Colors.purple, title: ''),
      PieChartSectionData(value: 5, color: Colors.cyan, title: ''),
      PieChartSectionData(value: 5, color: Colors.lightBlue.shade200, title: ''),
    ],
  };

  final Map<String, List<Map<String, dynamic>>> categoryList = {
    'Daily': [
      {'category': 'Food', 'color': Colors.orange},
      {'category': 'Transport', 'color': Colors.blue},
      {'category': 'Entertainment', 'color': Colors.red},
      {'category': 'Hospital', 'color': Colors.pink},
    ],
    'Weekly': [
      {'category': 'Education', 'color': Colors.green},
      {'category': 'Transport', 'color': Colors.blue},
      {'category': 'Bill', 'color': Colors.purple},
      {'category': 'Loan', 'color': Colors.teal},
    ],
    'Monthly': [
      {'category': 'Education', 'color': Colors.green},
      {'category': 'Transport', 'color': Colors.blue},
      {'category': 'Medicine', 'color': Colors.cyan},
      {'category': 'Shopping', 'color': Colors.brown},
    ],
    'Yearly': [
      {'category': 'Others', 'color': Colors.grey},
      {'category': 'Food', 'color': Colors.green},
      {'category': 'Transport', 'color': Colors.blue},
      {'category': 'Entertainment', 'color': Colors.red},
      {'category': 'Bill', 'color': Colors.purple},
      {'category': 'Medicine', 'color': Colors.cyan},
      {'category': 'Savings', 'color': Colors.lightBlue.shade200},
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Determine the AppBar text color based on the theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Report',
          style: TextStyle(
            fontSize: 22.0,
            color: appBarTextColor, // Dynamically set text color
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ToggleBar for switching report period
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildToggleButton('Daily'),
                _buildToggleButton('Weekly'),
                _buildToggleButton('Monthly'),
                _buildToggleButton('Yearly'),
              ],
            ),
          ),

          // PieChart for the selected period
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: PieChart(
                PieChartData(
                  sections: reportData[selectedPeriod]!,
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ),

          // List of categories with their colors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: categoryList[selectedPeriod]!.map((category) {
                return Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: category['color'] as Color,
                      ),
                      SizedBox(width: 10),
                      Text(
                        category['category'] as String,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ToggleButton for period selection
  Widget _buildToggleButton(String period) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPeriod = period;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Chip(
          label: Text(
            period,
            style: TextStyle(
              color: selectedPeriod == period ? Colors.white : Colors.black,
            ),
          ),
          backgroundColor: selectedPeriod == period
              ? Colors.purple
              : Colors.grey.shade200,
        ),
      ),
    );
  }
}
