# UPI Transaction Parser

A lightweight Dart package for parsing UPI transaction SMS messages into structured transaction objects.

The package extracts transaction amount, merchant information, transaction type (income/expense), and spending category from raw UPI SMS messages using pattern matching and keyword detection.

Perfect for expense trackers, personal finance applications, transaction analyzers, and financial dashboards.

---

## Features

Transaction amount extraction

Income / Expense detection

Merchant identification

Automatic spending categorization

UPI ID fallback detection

JSON serialization support

Pure Dart implementation

---

## Getting Started

### 1. Add the dependency

```yaml
dependencies:
  upi_transaction_parser: ^0.0.1
```

### 2. Install dependencies

```bash
flutter pub get
```

---

## Usage

### Import the package

```dart
import 'package:upi_transaction_parser/upi_transaction_parser.dart';
```

### Parse a transaction message

```dart
final transaction = UpiParser.parse(
  'Paid Rs. 250 to Swiggy via UPI',
  DateTime.now(),
);

print(transaction);
```

### Output

```text
UpiTransaction(
  amount: 250.0,
  merchant: Swiggy,
  type: expense,
  category: Food & Dining
)
```

---

## Expense Transaction Example

```dart
final transaction = UpiParser.parse(
  'Paid Rs. 499 to Amazon via UPI',
  DateTime.now(),
);

print(transaction?.merchant);
print(transaction?.category);
```

Output:

```text
Amazon
Shopping
```

---

## Income Transaction Example

```dart
final transaction = UpiParser.parse(
  'Received Rs. 5000 from Rahul',
  DateTime.now(),
);

print(transaction?.type);
print(transaction?.category);
```

Output:

```text
TransactionType.income
Income
```


---

## Supported Message Formats

The parser supports common UPI and banking transaction formats such as:

```text
Paid Rs. 250 to Swiggy via UPI

Received Rs. 500 from Rahul

INR 1,200 debited from account

₹999 transferred to Amazon

Rs. 350 credited to your account

Sent Rs. 150 to abc@ybl
```

---

## Transaction Model

The parser returns a structured `UpiTransaction` object.

```dart
class UpiTransaction {
  final double amount;
  final String merchant;
  final TransactionType type;
  final DateTime date;
  final String category;
  final String rawMessage;
}
```

---

## Transaction Type

```dart
enum TransactionType {
  income,
  expense,
}
```

---

## JSON Serialization

### Convert transaction to JSON

```dart
final json = transaction.toJson();
```

Example Output:

```json
{
  "amount": 250.0,
  "merchant": "Swiggy",
  "type": "expense",
  "date": "2025-06-06T12:00:00.000",
  "category": "Food & Dining",
  "rawMessage": "Paid Rs. 250 to Swiggy via UPI"
}
```

### Restore transaction from JSON

```dart
final transaction =
    UpiTransaction.fromJson(json);
```

---

## Components

### UpiParser

Main parser engine responsible for:

* Amount extraction
* Merchant extraction
* Transaction type detection
* Category detection

### UpiTransaction

Structured model representing a parsed transaction.

### TransactionType

Enum representing transaction type.

```dart
TransactionType.income
TransactionType.expense
```

---

## Package Structure

```text
lib/
├── upi_transaction_parser.dart
└── src/
    ├── parser_engine.dart
    ├── transaction_model.dart
    └── transaction_type.dart
```

---


## License

MIT License


