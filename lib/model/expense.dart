class Expense {
  String id;
  String category;
  double amount;
  String description;
  DateTime date;

  Expense({
    required this.id,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
  });

  // Convert a Expense object into a Map (used for sending data to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),  // Convert DateTime to ISO8601 format string
    };
  }

  // Create an Expense object from a Firestore document (used when retrieving data from Firestore)
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] ?? '',
      category: map['category'] ?? '',
      amount: map['amount'] ?? 0.0,
      description: map['description'] ?? '',
      date: DateTime.parse(map['date']),  // Convert ISO8601 string back to DateTime
    );
  }
}
