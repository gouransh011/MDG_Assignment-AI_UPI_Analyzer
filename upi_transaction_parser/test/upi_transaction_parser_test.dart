import 'package:test/test.dart';
import 'package:upi_transaction_parser/upi_transaction_parser.dart';

void main() {
  group('UPI Parser Tests', () {
    test('Should parse expense transaction correctly', () {
      final transaction = UpiParser.parse(
        'Paid Rs. 250 to Swiggy via UPI',
        DateTime(2025, 1, 1),
      );

      expect(transaction, isNotNull);
      expect(transaction!.amount, 250);
      expect(transaction.type, TransactionType.expense);
    });

    test('Should parse income transaction correctly', () {
      final transaction = UpiParser.parse(
        'Received Rs. 500 from Rahul',
        DateTime(2025, 1, 1),
      );

      expect(transaction, isNotNull);
      expect(transaction!.amount, 500);
      expect(transaction.type, TransactionType.income);
    });

    test('Should return null for non-transaction message', () {
      final transaction = UpiParser.parse(
        'Hello, how are you?',
        DateTime(2025, 1, 1),
      );

      expect(transaction, isNull);
    });
  });
}