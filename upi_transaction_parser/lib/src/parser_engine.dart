import 'transaction_model.dart';
import 'transaction_type.dart';

class UpiParser {
  static final RegExp _amountRegex = RegExp(
    r'(?:Rs\.?|INR|₹)\s*([\d,]+(?:\.\d{1,2})?)', caseSensitive: false,
  );

  static final List<String> _debitKeywords = [
    'debited', 'paid', 'sent', 'transferred', 'spent', 'withdrawn', 'declined'
  ];

  static final List<String> _creditKeywords = [
    'credited', 'received', 'added', 'refunded', 'deposited'
  ];

  // Parses a raw SMS message text into a UpiTransaction
  static UpiTransaction? parse(String message, DateTime date) {
    
    final amountMatch = _amountRegex.firstMatch(message);
    if (amountMatch == null) {
      return null;
    }

    // Remove commas in amounts (e.g., "1,250.00" -> 1250.0)
    final amountString = amountMatch.group(1)!.replaceAll(',', '');

    final amount = double.tryParse(amountString) ?? 0.0;
    if (amount <= 0.0) return null;

    // To determine Transaction Type
    final messageLower = message.toLowerCase();
    TransactionType type = TransactionType.expense; // Default fallback

    bool hasDebit = _debitKeywords.any((kw) => messageLower.contains(kw));
    bool hasCredit = _creditKeywords.any((kw) => messageLower.contains(kw));

    if (hasCredit && !hasDebit) {
      type = TransactionType.income;
    } 
    else if (hasDebit) {
      type = TransactionType.expense;
    } 
    else {
      if (messageLower.contains(' received from ') || messageLower.contains('credited by')) {
        type = TransactionType.income;
      }
    }

    String merchant = _extractMerchant(message, type);

    String category = _categorize(merchant, type);

    return UpiTransaction(
      amount: amount,
      merchant: merchant,
      type: type,
      date: date,
      category: category,
      rawMessage: message,
    );
  }

  static String _extractMerchant(String message, TransactionType type) {

    if (type == TransactionType.expense) {
      final toMatches = [
        RegExp(r'(?:paid|sent|transferred|transfer)\s+to\s+([^.\n]+)', caseSensitive: false),
        RegExp(r'(?:spent\s+on|to)\s+([^.\n]+)', caseSensitive: false),
        RegExp(r'via\s+upi\s+to\s+([^.\n]+)', caseSensitive: false),
      ];

      for (var regex in toMatches) {
        final match = regex.firstMatch(message);
        if (match != null) {
          return _cleanMerchantName(match.group(1)!);
        }
      }
    }
    else {
      final fromMatches = [
        RegExp(r'(?:received|transferred)\s+from\s+([^.\n]+)', caseSensitive: false),
        RegExp(r'(?:credited|sent)\s+by\s+([^.\n]+)', caseSensitive: false),
      ];

      for (var regex in fromMatches) {
        final match = regex.firstMatch(message);
        if (match != null) {
          return _cleanMerchantName(match.group(1)!);
        }
      }
    }

    //If we couldn't find a name, look for a UPI ID (e.g., rahul@okaxis)
    final upiIdRegex = RegExp(r'([a-zA-Z0-9.\-_]+@[a-zA-Z]+)');
    final upiMatch = upiIdRegex.firstMatch(message);
    if (upiMatch != null) {
      return upiMatch.group(1)!;
    }

    return 'Unknown Merchant';
  }

  // Cleans up any trailing words, transaction IDs, or reference codes from the merchant name
  static String _cleanMerchantName(String name) {
    String clean = name.trim();

    // Remove reference terms like "Ref", "Ref no", "Txn ID", "via UPI"
    final stopWords = [
      RegExp(r'\bref\b.*', caseSensitive: false),
      RegExp(r'\btxn\b.*', caseSensitive: false),
      RegExp(r'\bvia\s+upi\b.*', caseSensitive: false),
      RegExp(r'\bupi\b.*', caseSensitive: false),
      RegExp(r'\bfor\b.*', caseSensitive: false),
      RegExp(r'\bon\b.*', caseSensitive: false),
      RegExp(r'\busing\b.*', caseSensitive: false),
      RegExp(r'\bval\b.*', caseSensitive: false),
      RegExp(r'\bfrom\b.*', caseSensitive: false),
    ];

    for (var stopWord in stopWords) {
      clean = clean.split(stopWord).first.trim();
    }

    // Remove special characters, digits at the end, etc.
    clean = clean.replaceAll(RegExp(r'[^\w\s@.]'), '').trim();

    return clean.isEmpty ? 'Unknown Merchant' : clean;
  }

  /// To categorize transactions based on merchant keywords
  static String _categorize(String merchant, TransactionType type) {
    final m = merchant.toLowerCase();

    if (type == TransactionType.income) {
      if (m.contains('salary') || m.contains('employer')) {
        return 'Salary';
      }
      return 'Income';
    }

    if (m.contains('swiggy') || m.contains('zomato') || m.contains('food') || m.contains('cafe') || m.contains('restaurant') || m.contains('eats')) {
      return 'Food & Dining';
    }
    if (m.contains('amazon') || m.contains('flipkart')  || m.contains('retail') || m.contains('store') || m.contains('mall')) {
      return 'Shopping';
    }
    if (m.contains('netflix') || m.contains('spotify') || m.contains('prime') || m.contains('hotstar') || m.contains('game')  || m.contains('bookmyshow') || m.contains('cinema')) {
      return 'Entertainment';
    }
    if (m.contains('uber') || m.contains('ola') || m.contains('rapido') || m.contains('metro') || m.contains('petrol') || m.contains('fuel')) {
      return 'Travel & Transport';
    }
    if (m.contains('airtel') || m.contains('jio') || m.contains('recharge') || m.contains('electricity') || m.contains('bill') || m.contains('water') || m.contains('gas')) {
      return 'Bills & Utilities';
    }

    return 'Others';
  }
}