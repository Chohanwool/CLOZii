import 'package:intl/intl.dart';

String formatPrice(int number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}