import 'package:upi_transaction_parser/upi_transaction_parser.dart';

class InsightGenerator {
  static List<String> generateInsights(List<UpiTransaction> transactions) {
    final List<String> insights = [];

    if (transactions.isEmpty) {
      insights.add('No transactions found.');
      return insights;
    }

    double income = 0;
    double expense = 0;

    final Map<String, double> categoryTotals = {};
    final Map<String, int> merchantFrequency = {};

    double highestExpense = 0;
    String highestExpenseMerchant = '';

    for (final tx in transactions) {
      if (tx.type == TransactionType.income) {
        income += tx.amount;
      } 
      else {
        expense += tx.amount;

        if (tx.amount > highestExpense) {
          highestExpense = tx.amount;
          highestExpenseMerchant = tx.merchant;
        }
      }

      categoryTotals[tx.category] = (categoryTotals[tx.category] ?? 0) + tx.amount;
      merchantFrequency[tx.merchant] = (merchantFrequency[tx.merchant] ?? 0) + 1;
    }


    final savings = income - expense;

    if (income > 0) {
      if (savings >= 0) {
        insights.add('You saved ₹${savings.toStringAsFixed(0)} during this period.');
      } 
      else {
        insights.add('Your expenses exceeded income by ₹${(-savings).toStringAsFixed(0)}.');
      }
    }

    String topCategory = '';
    double topCategoryAmount = 0;

    categoryTotals.forEach((category, amount) {
      if (amount > topCategoryAmount) {
        topCategoryAmount = amount;
        topCategory = category;
      }
    });

    if (topCategory.isNotEmpty) {
      insights.add('Your top spending category is $topCategory with ₹${topCategoryAmount.toStringAsFixed(0)} spent.');
    }


    if (highestExpenseMerchant.isNotEmpty) {
      insights.add('Largest expense was ₹${highestExpense.toStringAsFixed(0)} at $highestExpenseMerchant.');
    }


    String topMerchant = '';
    int maxCount = 0;

    merchantFrequency.forEach((merchant, count) {
      if (count > maxCount) {
        maxCount = count;
        topMerchant = merchant;
      }
    });

    if (topMerchant.isNotEmpty) {
      insights.add('$topMerchant appeared in $maxCount transactions.');
    }

    insights.add( 'A total of ${transactions.length} transactions were analyzed.');

    return insights;
  }
}