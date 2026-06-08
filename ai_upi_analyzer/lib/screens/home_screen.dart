import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_state.dart';

class HomeScreen extends StatelessWidget{
        const HomeScreen({super.key});

        @override
        Widget build(BuildContext context) {
          return Scaffold(
              appBar: AppBar(title: const Text('AI UPI Analyzer')),
              body: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                  }

                  if (state is TransactionLoaded) {
                        return ListView.builder(
                          itemCount: state.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = state.transactions[index];

                            return ListTile(title: Text(transaction.merchant),subtitle: Text(transaction.category),trailing: Text('₹${transaction.amount}'));
                          },
                        );
                  }
                  if (state is TransactionError) {
                      return Center(
                        child: Text(state.message),
                      );
                  } 
                  
                  return const Center(child: Text('No Transactions Found'));
                }
                )
          );
        }
}