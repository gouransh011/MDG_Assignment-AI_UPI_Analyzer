# AI UPI Analyzer

AI UPI Analyzer is a Flutter application that automatically reads SMS messages from an Android device, extracts UPI transaction details, and provides financial analytics and insights.

The application uses a reusable Dart package, **upi_transaction_parser**, to convert raw transaction SMS messages into structured transaction objects.

---

## Features

### SMS Transaction Analysis

* Reads SMS messages from the device inbox.
* Detects UPI and banking transaction messages.
* Parses transaction details such as:

  * Amount
  * Merchant
  * Transaction Type (Income / Expense)
  * Category

### Financial Dashboard

* Total Income
* Total Expense
* Recent Transactions
* Category-wise Spending Analysis

### AI Insights

Generates intelligent insights based on transaction history, including:

* Savings analysis
* Top spending category
* Largest expense
* Most frequent merchant
* Transaction activity summary

### Expense Distribution Chart

* Visual representation of spending across categories.
* Helps users quickly understand spending patterns.

### Refresh Support

* Reloads SMS data and analytics using a refresh action.

---

## Tech Stack

### Flutter

* Flutter
* Dart

### State Management

* flutter_bloc

### Native Android Integration

* Kotlin
* MethodChannel

### Charts

* fl_chart

### Permissions

* permission_handler

---

## Architecture

SMS Inbox
↓
Native Android (Kotlin)
↓
Method Channel
↓
Repository Layer
↓
UPI Transaction Parser Package
↓
BLoC State Management
↓
UI Dashboard

---

## Reusable Package

This project uses the reusable package:

**upi_transaction_parser**

The package extracts structured transaction information from raw SMS messages and can be reused in other Flutter or Dart projects.

Capabilities:

* Amount Extraction
* Merchant Extraction
* Income/Expense Detection
* Transaction Categorization

---

## Project Structure

lib/

├── bloc/

├── repository/

├── screens/

├── widgets/

├── utils/

└── main.dart

---

## Getting Started

### Clone Repository

```bash
git clone <repository-url>
```

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Android Permissions

The application requires:

```xml
<uses-permission android:name="android.permission.READ_SMS"/>
```

Grant SMS permission when prompted.

