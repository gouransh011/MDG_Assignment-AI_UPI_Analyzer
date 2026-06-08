import 'package:upi_transaction_parser/upi_transaction_parser.dart';

import 'native_sms_service.dart';
bool isUpiMessage(String message) {
  final text = message.toLowerCase();

  final upiKeywords = [
    'upi',
    'credited',
    'debited',
    'received',
    'paid',
    'sent',
    'transaction',
    'bank',
    'a/c',
    'account',
    'transferred',
  ];

  return upiKeywords.any(
    (keyword) => text.contains(keyword),
  );
}
class SmsRepository {
  final NativeSmsService smsService = NativeSmsService();
  Future<List<UpiTransaction>> getTransactions() async {

    final List<String> messages = await smsService.getSmsMessages();


    final List<UpiTransaction> transactions = [];

    for (final message in messages) {
      if(!isUpiMessage(message)){
        continue;
      }
      final transaction = UpiParser.parse(message,DateTime.now());
      if (transaction != null) {
        transactions.add(transaction);
      }
    }

    return transactions;
  }
}