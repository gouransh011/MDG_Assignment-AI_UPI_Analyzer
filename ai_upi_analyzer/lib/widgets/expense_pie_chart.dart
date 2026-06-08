import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensePieChart extends StatelessWidget {
  final Map<String, double> categoryTotals;

  const ExpensePieChart({super.key,required this.categoryTotals});

  @override
  Widget build(BuildContext context) {
    if (categoryTotals.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
    ];

    int colorIndex = 0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Expense Distribution',
              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: categoryTotals.entries.map((entry) {

                    final section = PieChartSectionData(
                      value: entry.value,
                      title: entry.key,
                      radius: 90,
                      color: colors[
                          colorIndex++ % colors.length],
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );

                    return section;

                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}