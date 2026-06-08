import 'package:flutter/material.dart';
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
             
              home: Scaffold(
                appBar: AppBar(title: const Text('AI UPI Analyzer')),

                body: const Center(
                    child:Text(
                      'Welcome to AI UPI Analyzerr', style: TextStyle( fontSize: 22),
                    )
                )
              )
          );
       }
}
