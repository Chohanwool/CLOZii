import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/presentation/widgets/date_picker_field.dart';
import 'package:clozii/features/auth/presentation/widgets/gender_dropdown_field.dart';
import 'package:clozii/features/auth/presentation/widgets/name_field.dart';
import 'package:clozii/features/auth/presentation/widgets/phone_number_field.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int _currentStep = 1;

  bool _isNameValid = false;
  DateTime? _birthDate;
  String? _selectedGender;

  // 상수로 분리
  static const int _phoneNumberMaxLength = 11;
  static const String _phoneNumberPrefix = '+639';

  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();

  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateFocusNode = FocusNode();

  final FocusNode _genderFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _phoneNumberController.addListener(_checkPhoneNumberComplete);

    _nameController.addListener(_checkNameValid);

    _dateController.addListener(_checkBirthdayValid);

    _phoneNumberFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _phoneNumberController.removeListener(_checkPhoneNumberComplete);
    _nameController.removeListener(_checkNameValid);
    _dateController.removeListener(_checkBirthdayValid);

    _phoneNumberController.dispose();
    _nameController.dispose();

    _phoneNumberFocusNode.dispose();
    _nameFocusNode.dispose();

    _dateController.dispose();
    _dateFocusNode.dispose();

    _genderFocusNode.dispose();
    super.dispose();
  }

  void _checkBirthdayValid() {
    if (_birthDate != null) {
      setState(() {
        _currentStep = 4;
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _genderFocusNode.requestFocus();
        }
      });
    }
  }

  void _checkNameValid() {
    final isValid = _nameController.text.trim().isNotEmpty;

    if (_isNameValid != isValid) {
      setState(() {
        _isNameValid = isValid;
      });
    }
  }

  void _checkPhoneNumberComplete() {
    final cleanNumber = _phoneNumberController.text.replaceAll('-', '');

    if (cleanNumber.length == _phoneNumberMaxLength && _currentStep == 1) {
      debugPrint(_completePhoneNumber);

      setState(() {
        _currentStep = 2;
      });

      // 약간의 지연 후 다음 필드로 포커스 이동
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _nameFocusNode.requestFocus();
        }
      });
    }
  }

  // 전화번호 완성
  String get _completePhoneNumber {
    final cleanNumber = _phoneNumberController.text.replaceAll('-', '');

    if (cleanNumber[0] != '0' && cleanNumber[1] != '9') {
      throw Exception();
    }

    final numberWithoutPrefix = cleanNumber.replaceFirst('09', '');
    return '$_phoneNumberPrefix$numberWithoutPrefix';
  }

  void _nameTypedCheck() {
    final phoneNumber = _completePhoneNumber;
    final name = _nameController.text.trim();

    if (phoneNumber.length == 13 && name.isNotEmpty) {
      setState(() {
        _currentStep = 3;
      });
      _dateFocusNode.requestFocus();
    }
  }

  void allFieldValidCheck() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      bottomSheet: (_currentStep == 2 || _currentStep == 4)
          ? Material(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                color: Colors.transparent,
                child: _currentStep == 2
                    ? CustomButton(
                        text: 'Continue',
                        onTap: _isNameValid ? _nameTypedCheck : null,
                        height: 50,
                      )
                    : CustomButton(
                        // _currentStep == 3
                        text: 'Verify & Complete',
                        onTap: _birthDate != null ? allFieldValidCheck : null,
                        height: 50,
                      ),
              ),
            )
          : null,

      bottomNavigationBar: Container(height: kToolbarHeight),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Signup with phone number',
                style: context.textTheme.titleLarge,
              ),

              const SizedBox(height: 24.0),

              // 성별 선택 필드 (조건부 렌더링)
              if (_currentStep >= 4) ...[
                  GenderDropdownField(
                    focusNode: _genderFocusNode,
                    selectedGender: _selectedGender,
                    onChanged: (val) => setState(() => _selectedGender = val),
                  ),
                  const SizedBox(height: 24.0),
                ],

              // 생년월일 선택 필드 (조건부 렌더링)
              if (_currentStep >= 3) ...[
                DatePickerField(
                  controller: _dateController,
                  focusNode: _dateFocusNode,
                  label: 'Date of Birth',
                  hintText: 'MM/DD/YYYY',
                  onChanged: (date) {
                    setState(() {
                      _birthDate = date;
                    });
                  },
                ),

                const SizedBox(height: 36.0),
              ],

              // 이름 필드 (조건부 렌더링)
              if (_currentStep >= 2) ...[
                NameField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                ),

                const SizedBox(height: 36.0),
              ],

              PhoneNumberField(
                // onChanged: _onPhoneNumberTyped,
                controller: _phoneNumberController,
                focusNode: _phoneNumberFocusNode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
