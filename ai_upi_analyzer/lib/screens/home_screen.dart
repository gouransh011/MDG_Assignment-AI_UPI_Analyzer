import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_state.dart';
import '../bloc/transaction_event.dart';

import '../widgets/summary_card.dart';
import 'package:upi_transaction_parser/upi_transaction_parser.dart';

import '../widgets/ai_insight_card.dart';
import '../utils/insight_generator.dart' ;

import '../widgets/expense_pie_chart.dart';
class HomeScreen extends StatelessWidget{
        const HomeScreen({super.key});

        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('AI UPI Analyzer'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {

                    context.read<TransactionBloc>().add(
                      LoadTransactions(),
                    );

                  },
                ),
              ],
            ),
            body: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

          if (state is TransactionLoaded) {
            final transactions = state.transactions;
            double income = 0;
            double expense = 0;
            
            final Map<String, double> categoryTotals = {};
            final Map<String, double> expenseCategoryTotals = {};

            for (final tx in transactions) {
              if (tx.type == TransactionType.income) {
                income += tx.amount;
              } else {
                expense += tx.amount;
              }

              categoryTotals[tx.category] = (categoryTotals[tx.category] ?? 0) + tx.amount;
              if (tx.type == TransactionType.expense) {

                expenseCategoryTotals[tx.category] =
                    (expenseCategoryTotals[tx.category] ?? 0)
                    + tx.amount;
              }
            
            }
            final insights = InsightGenerator.generateInsights(transactions);
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SummaryCard(
                          title: 'Income',
                          value: '₹${income.toStringAsFixed(0)}',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SummaryCard(
                          title: 'Expense',
                          value: '₹${expense.toStringAsFixed(0)}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  const Text(
                    'Category Analysis',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  
                  Card(
                    elevation: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryTotals.length,
                      itemBuilder: (context, index) {
                        final category = categoryTotals.keys.elementAt(index);
                        final totalAmount = categoryTotals[category]!;
                        
                        return ListTile(
                          leading: const Icon(Icons.pie_chart, color: Colors.blueAccent),
                          title: Text(category),
                          trailing: Text('₹${totalAmount.toStringAsFixed(0)}',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  ListView.builder(
                    shrinkWrap: true, 
                    physics: const NeverScrollableScrollPhysics(), 
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final tx = transactions[index];
                      final isIncome = tx.type == TransactionType.income;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isIncome ? Colors.green : Colors.red,
                            child: Icon(isIncome ? Icons.arrow_downward : Icons.arrow_upward,color: isIncome ? Colors.green : Colors.red),
                          ),
                          title: Text(tx.merchant,style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(tx.category),
                          trailing: Text(
                            '₹${tx.amount.toStringAsFixed(0)}',
                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: isIncome ? Colors.green : Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AiInsightCard(
                    insights: insights,
                  ),

                  const SizedBox(height: 20),
                  const SizedBox(height: 20),

                  ExpensePieChart(
                    categoryTotals: expenseCategoryTotals,
                  ),

                  const SizedBox(height: 20),
                ],
              ),

            );
            
          }

          if (state is TransactionError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          }

          return const Center(child: Text('No Transactions Found'));
        },
      ),
    );
  }
}