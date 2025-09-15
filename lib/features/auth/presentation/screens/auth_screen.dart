import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/data/auth_step.dart';
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/features/auth/data/constants.dart';
import 'package:clozii/features/auth/presentation/screens/verification_screen.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/date_picker_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/gender_dropdown_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/name_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/phone_number_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.authType});

  final AuthType authType;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // _currentStep을 [ 1, 2, 3, 4 ]로 비교하는 대신
  // enum으로 관리해서 가독성 향상시킴
  late AuthStep _currentStep;

  bool _isNameValid = false;
  DateTime? _birthDate;
  String? _selectedGender;

  // 컨트롤러
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // 포커스 노드
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();

  // 전역 키
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentStep = widget.authType == AuthType.signup
        ? AuthStep.phoneSignup
        : AuthStep.phoneLogin;

    _phoneNumberController.addListener(_checkPhoneNumberValid);
    _nameController.addListener(_updateNameValidationState);
    _dateController.addListener(_proceedIfBirthdaySelected);

    _phoneNumberFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _phoneNumberController.removeListener(_checkPhoneNumberValid);
    _nameController.removeListener(_updateNameValidationState);
    _dateController.removeListener(_proceedIfBirthdaySelected);

    _phoneNumberController.dispose();
    _nameController.dispose();

    _phoneNumberFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  // 전화번호 완성 메서드: '09...' -> '+639...'
  String get _completePhoneNumber {
    final cleanNumber = _phoneNumberController.text
        .replaceAll('-', '')
        .replaceFirst('09', '');

    return '$phoneNumberPrefix$cleanNumber';
  }

  // 전화번호 입력 단계인지 확인하는 메서드
  bool get _isPhoneStep =>
      _currentStep == AuthStep.phoneSignup ||
      _currentStep == AuthStep.phoneLogin;

  // 이름 필드가 비어 있는지 확인하는 메서드
  bool _isNameNotEmpty() => _nameController.text.trim().isNotEmpty;

  void _checkPhoneNumberValid() async {
    final cleanNumber = _phoneNumberController.text.replaceAll('-', '');

    // 입력된 전화번호 길이가 11 이면서
    // _currentStep == (AuthStep.phoneSignup 또는 AuthStep.phoneLogin) 인 경우
    if (cleanNumber.length == phoneNumberMaxLength && _isPhoneStep) {
      debugPrint(_completePhoneNumber);

      // 로그인 화면에서는 전화번호 입력 필드만 필요하므로, _currentStep을 변경 시킬 필요가 없음
      if (widget.authType == AuthType.login) {
        return;
      }

      setState(() {
        _currentStep = AuthStep.name;
      });

      // 이름 필드로 포커스 이동
      _nameFocusNode.requestFocus();
    }

    // 번호가 입력 될때마다 UI 리로드 (suffixIcon 표시에 필요!)
    setState(() {});
  }

  // 이름 필드 입력값 변화 감지 - 버튼 활성화/비활성화 에 사용됨
  void _updateNameValidationState() {
    final isValid = _isNameNotEmpty();

    if (_isNameValid != isValid) {
      setState(() => _isNameValid = isValid);
    }
  }

  // 이름이 비어있지 않으면 다음 단계로 이동
  void _proceedIfNameFilled() {
    if (_isNameNotEmpty()) {
      setState(() => _currentStep = AuthStep.birthdate);
      _dateFocusNode.requestFocus();
    }
  }

  // 생년월일 선택시 다음 단계로 이동
  void _proceedIfBirthdaySelected() {
    if (_birthDate != null) {
      setState(() {
        _currentStep = AuthStep.gender;
      });

      _genderFocusNode.requestFocus();
    }
  }

  /// 성별 선택 후, 모든 필드 검증 -> 약관 표시 -> 인증 화면으로 이동
  void _allFieldValidCheck() async {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    // 이미 가입된 전화번호인지 확인
    if (_isPhoneNumberRegistered()) {
      if (widget.authType == AuthType.login) {
        _navigateToVerification(_completePhoneNumber);
      }

      if (widget.authType == AuthType.signup) {
        final result = await showAlertDialog(
          context,
          'This phone number is already registered. Try signing in.',
        );

        if (result != null && mounted) {
          Navigator.of(context).pop();
        }
      }

      return;
    }

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
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                phoneNumber: phone,
                authType: widget.authType,
              ),
            ),
          );
        } finally {
          // 전환 직전에 오버레이 제거 (mounted 체크는 OverlayEntry 제거엔 불필요)
          loading.remove();
        }
      }
    }
  }

  bool _isPhoneNumberRegistered() {
    // TODO: 입력된 전화번호로 가입된 계정이 있는지 확인하는 로직 구현
    // 로직 구현 후 함수 반환 타입을 Future<bool> 로 변경 예정

    // 임시로 '+639123456789' 가 가입된 번호라고 가정
    return _completePhoneNumber == '+639123456789';
  }

  void _navigateToVerification(String phone) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            VerificationScreen(phoneNumber: phone, authType: widget.authType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      bottomSheet:
          (_currentStep == AuthStep.name ||
              _currentStep == AuthStep.gender ||
              widget.authType == AuthType.login)
          ? KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                final buttonText = 'Continue';
                final buttonHeight = 50.0;

                Widget? button;

                if (_currentStep == AuthStep.name) {
                  button = CustomButton(
                    text: buttonText,
                    onTap: _isNameValid ? _proceedIfNameFilled : null,
                    height: buttonHeight,
                    isKeyboardVisible: isKeyboardVisible,
                  );
                }

                if (_currentStep == AuthStep.gender) {
                  button = CustomButton(
                    // _currentStep == 4
                    text: buttonText,
                    onTap: _birthDate != null ? _allFieldValidCheck : null,
                    height: buttonHeight,
                    isKeyboardVisible: isKeyboardVisible,
                  );
                }

                if (widget.authType == AuthType.login) {
                  button = CustomButton(
                    text: buttonText,
                    onTap: () {
                      if (_isPhoneNumberRegistered()) {
                        _navigateToVerification(_completePhoneNumber);
                      } else {
                        final isFormValid =
                            _formKey.currentState?.validate() ?? false;

                        if (!isFormValid) return;

                        showAlertDialog(
                          context,
                          'This phone number is not registered. Please sign up first.',
                        );
                      }
                    },

                    height: buttonHeight,
                    isKeyboardVisible: isKeyboardVisible,
                  );
                }

                return Material(
                  child: Container(
                    padding: !isKeyboardVisible
                        ? EdgeInsets.symmetric(horizontal: 16.0)
                        : null,
                    color: Colors.transparent,
                    child: button,
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
                Text(
                  headerTexts[_currentStep]!,
                  style: context.textTheme.titleLarge,
                ),

                const SizedBox(height: 24.0),

                if (_currentStep.index >= AuthStep.gender.index) ...[
                  GenderDropdownField(
                    focusNode: _genderFocusNode,
                    selectedGender: _selectedGender,
                    onChanged: (val) => setState(() => _selectedGender = val),
                  ),
                  const SizedBox(height: 36.0),
                ],

                if (_currentStep.index >= AuthStep.birthdate.index) ...[
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
                if (_currentStep.index >= AuthStep.name.index) ...[
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
