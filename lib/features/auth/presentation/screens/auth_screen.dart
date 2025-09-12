import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/presentation/screens/verification_screen.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/date_picker_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/gender_dropdown_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/name_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/phone_number_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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

      // 약간의 지연 후 다음 필드로 포커스 이동
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _nameFocusNode.requestFocus();
        }
      });

      return;
    }

    setState(() {});
  }

  void _changeHeaderText() {
    if (_currentStep == 2) {
      // _headerText = 'How do you want your neighbors to call you?';
      // _headerText = 'Got a nickname in mind?';
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

  /// Verify & Complete 버튼 클릭 처리
  void _allFieldValidCheck() async {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    // ✅ 모든 검증 통과
    final phone = _completePhoneNumber;
    final name = _nameController.text.trim();

    debugPrint('✅ VERIFIED: $name | $phone | $_birthDate | $_selectedGender');

    final isPop = await showModalBottomSheet(
      context: context,
      barrierColor: Colors.black26,
      backgroundColor: Colors.white,
      isScrollControlled: true, // 모달이 화면 높이만큼 채워짐
      // - 하지만 약관 위젯에서 Wrap 위젯 사용해서 내부 요소만큼만 모달이 채워짐
      builder: (context) => const TermsAndConditions(), // 모달 내용: 약관 위젯
    );

    // 약관 통과 시 인증번호 전송
    if (isPop != null) {
      await Future.delayed(const Duration(milliseconds: 350)); // 예시

      // if(mounted) 확인 후 호출
      if (mounted) {
        final loading = showLoadingOverlay(context); // ⬅️ 현재 화면 위에 로딩만 띄움

        try {
          //TODO: DB에 유저가 입력한 정보 저장
          await Future.delayed(
            const Duration(milliseconds: 800),
          ); // DB에 데이터를 저장하는 시간을 임의로 대체

          if (!mounted) return;

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const VerificationScreen()),
          );
        } finally {
          // 전환 직전에 오버레이 제거 (mounted 체크는 OverlayEntry 제거엔 불필요)
          loading.remove();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      bottomSheet: (_currentStep == 2 || _currentStep == 4)
          ? KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return Material(
                  child: Container(
                    padding: !isKeyboardVisible
                        ? EdgeInsets.symmetric(horizontal: 16.0)
                        : null,
                    color: Colors.transparent,
                    child: _currentStep == 2
                        ? CustomButton(
                            text: 'Continue',
                            onTap: _isNameValid ? _nameTypedCheck : null,
                            height: 50,
                            isKeyboardVisible: isKeyboardVisible,
                          )
                        : CustomButton(
                            // _currentStep == 4
                            text: 'Verify & Complete',
                            onTap: _birthDate != null
                                ? _allFieldValidCheck
                                : null,
                            height: 50,
                            isKeyboardVisible: isKeyboardVisible,
                          ),
                  ),
                );
              },
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
                  const SizedBox(height: 36.0),
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
