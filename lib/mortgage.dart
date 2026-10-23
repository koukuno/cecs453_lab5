import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class Mortgage extends ChangeNotifier {
  Decimal _amount;
  Decimal _rate;
  int _years;

  Decimal get amount => _amount;
  Decimal get rate => _rate;
  int get years => _years;

  Mortgage({required this._amount, required this._rate, required this._years});

  Decimal getMonthlyPayment() {
    final monthlyRate = (rate / Decimal.fromInt(12)).toDecimal(scaleOnInfinitePrecision: 8);
    final numerator = amount * monthlyRate;
    final denominator = Decimal.fromInt(1) - (Decimal.fromInt(1) + monthlyRate).pow(-12 * years).toDecimal(scaleOnInfinitePrecision: 8);
    return (numerator / denominator).toDecimal(scaleOnInfinitePrecision: 2);
  }

  Decimal getTotalPayment() => getMonthlyPayment() * Decimal.fromInt(12) * Decimal.fromInt(years);
  String formatMonthlyPayment() => getMonthlyPayment().toStringAsFixed(2);
  String formatTotalPayment() => getTotalPayment().toStringAsFixed(2);

  void update({required Decimal amount, required Decimal rate, required int years}) {
    _amount = amount;
    _rate = rate;
    _years = years;
    notifyListeners();
  }

}
