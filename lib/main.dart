import 'package:expense_tracker_app/login_screen.dart';
import 'package:expense_tracker_app/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'splash_screen.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'package:expense_tracker_app/add_expense_screen.dart';  // This is the AddExpenseScreen in the lib folder
import 'transaction_history_screen.dart';
import 'categories_screen.dart';
import 'budgeting_screen.dart';
import 'reports_screen.dart';
import 'settings_screen.dart';
import 'theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'screens/add_expense_screen.dart';  // This is the AddExpenseScreen under lib/screens
import 'screens/expense_list_screen.dart';  // Ensure you have the correct import for this screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode, // Theme mode based on the provider
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',  // SplashScreen is the initial screen
      routes: {
        '/': (context) => SplashScreen(),  // Splash screen as the entry point
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/addExpenseLib': (context) => AddExpenseScreen(), // Using the AddExpenseScreen in lib
        '/history': (context) => TransactionHistoryScreen(),
        '/categories': (context) => CategoriesScreen(),
        '/budgeting': (context) => BudgetingScreen(),
        '/reports': (context) => ReportsScreen(),
        '/settings': (context) => SettingsScreen(),
        '/expenseList': (context) => ExpenseListScreen(),
      },
    );
  }
}
