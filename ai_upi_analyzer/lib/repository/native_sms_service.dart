import 'package:flutter/services.dart';

class NativeSmsService {

  static const MethodChannel _channel = MethodChannel('ai_upi_analyzer/sms');

  Future<String> testChannel() async {

    final result = await _channel.invokeMethod('testChannel');
    return result.toString();
  }

  Future<List<String>> getSmsMessages() async {

  final result = await _channel.invokeMethod('getSmsMessages');
  return List<String>.from(result);
  }
}