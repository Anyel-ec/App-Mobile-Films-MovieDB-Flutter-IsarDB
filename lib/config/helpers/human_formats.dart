import 'package:intl/intl.dart';

class HumanFormants{
  static String number(double number, [int decimalDigits = 1]){

    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en_'
    ).format(number);
    
    return formatterNumber;
  }
}