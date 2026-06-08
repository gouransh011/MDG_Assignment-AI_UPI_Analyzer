import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/sms_repository.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent,TransactionState>{
    final SmsRepository repository;

    TransactionBloc(this.repository) : super(TransactionInitial()) {
            on<LoadTransactions>(_loadTransactions);
    }

    Future<void> _loadTransactions(LoadTransactions event,Emitter<TransactionState> emit) async {
        emit(TransactionLoading());
        try {
          final transactions = await repository.getTransactions();
          emit(TransactionLoaded(transactions));
        }
        catch(e) {
          emit(TransactionError(e.toString()));
        }
    }
}