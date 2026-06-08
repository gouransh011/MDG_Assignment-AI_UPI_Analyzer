import 'package:upi_transaction_parser/upi_transaction_parser.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}


class TransactionLoaded extends TransactionState {

  final List<UpiTransaction> transactions;

  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}