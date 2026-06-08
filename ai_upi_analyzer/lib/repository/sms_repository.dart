import 'package:upi_transaction_parser/upi_transaction_parser.dart';

class SmsRepository {
  Future<List<UpiTransaction>> getTransactions() async {
    //since in actual fetching of the data we would have some delay so we are creating that delay by our own for testing
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final messages = [
      'Rs.500 paid to Amazon via UPI',
      'Rs.1200 received from Salary Account',
      'INR 250 paid to Swiggy',
      'Rs.800 credited from Employer',
    ];

    final List<UpiTransaction> transactions = [];

    for (final message in messages) {

      final transaction = UpiParser.parse(message,DateTime.now());

      if (transaction != null) {
        transactions.add(transaction);
      }
    }

    return transactions;
  }
}