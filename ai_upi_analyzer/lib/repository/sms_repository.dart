import 'package:upi_transaction_parser/upi_transaction_parser.dart';

import 'native_sms_service.dart';

class SmsRepository {
  final NativeSmsService smsService = NativeSmsService();
  Future<List<UpiTransaction>> getTransactions() async {

    final List<String> messages = await smsService.getSmsMessages();


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