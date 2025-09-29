import 'package:clozii/features/auth_old/data/constants.dart';
import 'package:flutter/cupertino.dart';

abstract class AuthBase<T extends StatefulWidget> extends State<T> {
  final TextEditingController phoneNumberController = TextEditingController();
  final FocusNode phoneNumberFocusNode = FocusNode();

  String get completePhoneNumber {
    final cleanNumber = phoneNumberController.text
        .replaceAll('-', '')
        .replaceFirst('09', '');
    return '$phoneNumberPrefix$cleanNumber';
  }
}
