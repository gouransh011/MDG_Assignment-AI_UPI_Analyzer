import 'package:flutter/material.dart';

class AiInsightCard extends StatelessWidget {
  final List<String> insights;

  const AiInsightCard({super.key,required this.insights});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.auto_awesome,size: 30,color: Colors.deepPurple),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: insights.map(
                        (insight) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('• $insight'),
                          );
                        },
                      ).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}