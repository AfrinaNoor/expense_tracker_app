import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/expense.dart';

Future<void> addExpenseToFirebase(Expense expense) async {
  try {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore.collection('expenses').add(expense.toMap());
    print('Expense added successfully!');
  } catch (e) {
    print('Error adding expense: $e');
  }
}

Stream<List<Expense>> getExpensesFromFirebase() {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  return _firestore.collection('expenses').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Expense.fromMap(doc.data() as Map<String, dynamic>)).toList();
  });
}
