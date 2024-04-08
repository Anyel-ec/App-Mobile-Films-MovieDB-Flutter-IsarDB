import 'package:intl/intl.dart';

class HumanFormants{
  static String number(double number){

    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en_'
    ).format(number);
    
    return formatterNumber;
  }
}