import 'package:upi_transaction_parser/upi_transaction_parser.dart';

void main() {
final messages = [
'Paid Rs. 250 to Swiggy via UPI',
'Received Rs. 5000 from Rahul',
'₹999 transferred to Amazon',
'Hello, how are you?',
];

for (final message in messages) {
final transaction = UpiParser.parse(
message,
DateTime.now(),
);

if (transaction == null) {
  print('No transaction found: $message');
  continue;
}

print('Amount: ${transaction.amount}');
print('Merchant: ${transaction.merchant}');
print('Type: ${transaction.type.name}');
print('Category: ${transaction.category}');
print('---');

}
}
