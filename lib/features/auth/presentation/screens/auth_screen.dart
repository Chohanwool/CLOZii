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
  String _headerText = 'Sign up with phone number.';
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

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _phoneNumberController.addListener(_checkPhoneNumberValid);

    _nameController.addListener(_checkNameValid);

    _dateController.addListener(_checkBirthdayValid);

    _phoneNumberFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _phoneNumberController.removeListener(_checkPhoneNumberValid);
    _nameController.removeListener(_checkNameValid);
    _dateController.removeListener(_checkBirthdayValid);

    _phoneNumberController.dispose();
    _nameController.dispose();

    _phoneNumberFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _checkBirthdayValid() {
    if (_birthDate != null) {
      setState(() {
        _currentStep = 4;
        _changeHeaderText();
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

  void _checkPhoneNumberValid() {
    final cleanNumber = _phoneNumberController.text.replaceAll('-', '');

    if (cleanNumber.length == _phoneNumberMaxLength && _currentStep == 1) {
      debugPrint(_completePhoneNumber);

      setState(() {
        _currentStep = 2;
        _changeHeaderText();
      });

      _nameFocusNode.requestFocus();
      return;
    }

    setState(() {});
  }

  void _changeHeaderText() {
    if (_currentStep == 2) {
      _headerText = 'What should we call you?';
    }
    if (_currentStep == 3) {
      _headerText = 'We need your birthdate to verify your age.';
    }
    if (_currentStep == 4) {
      _headerText = 'This helps us personalize your experience.';
    }
  }

  // 전화번호 완성
  String get _completePhoneNumber {
    final cleanNumber = _phoneNumberController.text
        .replaceAll('-', '')
        .replaceFirst('09', '');

    return '$_phoneNumberPrefix$cleanNumber';
  }

  void _nameTypedCheck() {
    final name = _nameController.text.trim();

    if (name.isNotEmpty) {
      setState(() {
        _currentStep = 3;
        _changeHeaderText();
      });
      _dateFocusNode.requestFocus();
    }
  }

  void allFieldValidCheck() {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    // ✅ 모든 검증 통과
    final phone = _completePhoneNumber;
    final name = _nameController.text.trim();

    print('✅ VERIFIED: $name | $phone | $_birthDate | $_selectedGender');
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_headerText, style: context.textTheme.titleLarge),

                const SizedBox(height: 24.0),

                if (_currentStep >= 4) ...[
                  GenderDropdownField(
                    focusNode: _genderFocusNode,
                    selectedGender: _selectedGender,
                    onChanged: (val) => setState(() => _selectedGender = val),
                  ),
                  const SizedBox(height: 24.0),
                ],

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
                  controller: _phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
