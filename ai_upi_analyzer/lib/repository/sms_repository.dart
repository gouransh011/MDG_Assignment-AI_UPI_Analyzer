import 'package:upi_transaction_parser/upi_transaction_parser.dart';

class SmsRepository {
    Future<List<UpiTransaction>> getTransactions() async {

         return [
          UpiTransaction(
            amount: 500,
            merchant: "Amazon",
            type: TransactionType.expense,
            date: DateTime.now(),
            category: "Shopping",
            rawMessage: "Dummy SMS",
          ),

          UpiTransaction(
            amount: 1200,
            merchant: "Salary",
            type: TransactionType.income,
            date: DateTime.now(),
            category: "Income",
            rawMessage: "Dummy SMS",
          ),
         ];
    }

    
}