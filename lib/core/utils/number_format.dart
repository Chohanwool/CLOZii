import 'package:intl/intl.dart';

String formatPrice(double number) {
  final formatter = NumberFormat('#,###');
  return formatter.format(number);
}