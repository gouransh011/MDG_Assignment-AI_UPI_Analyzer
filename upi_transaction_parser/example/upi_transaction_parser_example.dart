import 'package:upi_transaction_parser/upi_transaction_parser.dart';

void main() {
  final message = 'Paid Rs. 250 to Swiggy via UPI';
  final date = DateTime(2025, 1, 1);

  final transaction = UpiParser.parse(message, date);

  if (transaction == null) {
    print('No UPI transaction found.');
    return;
  }

  print('Amount: ${transaction.amount}');
  print('Merchant: ${transaction.merchant}');
  print('Type: ${transaction.type.name}');
  print('Category: ${transaction.category}');
  print('Date: ${transaction.date}');
}