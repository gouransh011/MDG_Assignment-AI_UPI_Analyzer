import 'transaction_type.dart';

class UpiTransaction {
  final double amount;
  final String merchant;
  final TransactionType type;
  final DateTime date;
  final String category;
  final String rawMessage;

  UpiTransaction({
    required this.amount,
    required this.merchant,
    required this.type,
    required this.date,
    required this.category,
    required this.rawMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'merchant': merchant,
      'type': type.name, 
      'date': date.toIso8601String(),
      'category': category,
      'rawMessage': rawMessage,
    };
  }

  
  factory UpiTransaction.fromJson(Map<String, dynamic> json) {
    return UpiTransaction(
      amount: (json['amount'] as num).toDouble(),
      merchant: json['merchant'] as String,
      type: TransactionType.values.firstWhere((e) => e.name == json['type']),
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      rawMessage: json['rawMessage'] as String,
    );
  }

  @override
  String toString() {
    return 'UpiTransaction(amount: $amount, merchant: $merchant, type: ${type.name}, category: $category)';
  }
}