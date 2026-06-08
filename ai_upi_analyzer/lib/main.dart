import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/transaction_bloc.dart';
import 'bloc/transaction_event.dart';
import 'repository/sms_repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AiUpiAnalyzerApp());
}

class AiUpiAnalyzerApp extends StatelessWidget {
  const AiUpiAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI UPI Analyzer',

      home: BlocProvider(
        create: (_) => TransactionBloc(SmsRepository())..add(LoadTransactions()),
        child: const HomeScreen()
      )
    );
  }
}