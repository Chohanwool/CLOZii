import 'package:clozii/core/constants/app_constants.dart';
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/data/auth_step.dart';
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/features/auth/data/constants.dart';
import 'package:clozii/features/auth/presentation/screens/auth_base_screen.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/date_picker_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/gender_dropdown_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/name_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/phone_number_field.dart';
import 'package:clozii/features/auth/presentation/widgets/auth_screen/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpScreen extends AuthBaseScreen {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends AuthBaseScreenState<SignUpScreen> {
  // _currentStep을 [ 1, 2, 3, 4 ]로 비교하는 대신
  // enum으로 관리해서 가독성 향상시킴
  late AuthStep _currentStep;

  bool _isNameValid = false;
  DateTime? _birthDate;
  String? _selectedGender;

  // 컨트롤러
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // 포커스 노드
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _genderFocusNode = FocusNode();

  // 전역 키
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _currentStep = AuthStep.phoneSignup;

    // 각 필드별 이벤트 리스너 등록하여 입력 값 변경 시 이벤트 발생
    phoneNumberController.addListener(proceedIfPhoneFilled);
    _nameController.addListener(_updateNameValidationState);
    _dateController.addListener(_proceedIfBirthdaySelected);

    // 포커스 상태 변경 시 이벤트 발생
    phoneNumberFocusNode.addListener(() {
      setState(() {});
    });

    debugPrint('AuthScreen initState: $_currentStep');
  }

  @override
  void dispose() {
    phoneNumberController.removeListener(proceedIfPhoneFilled);
    _nameController.removeListener(_updateNameValidationState);
    _dateController.removeListener(_proceedIfBirthdaySelected);

    phoneNumberController.dispose();
    phoneNumberFocusNode.dispose();

    _nameController.dispose();
    _nameFocusNode.dispose();

    _dateController.dispose();
    _dateFocusNode.dispose();

    _genderFocusNode.dispose();
    super.dispose();
  }

  // 전화번호 입력 단계인지 확인하는 메서드
  bool get _isPhoneStep => _currentStep == AuthStep.phoneSignup;

  // PhoneNumberField 입력 값 비어 있는지 확인
  bool get _isPhoneNumberNotEmpty =>
      phoneNumberController.text.trim().isNotEmpty;

  // NameField 입력 값 비어 있는지 확인
  bool _isNameNotEmpty() => _nameController.text.trim().isNotEmpty;

  //////////////////////////////////////////////////////////////

  // 이름 필드 입력값 변화 감지 - 버튼 활성화/비활성화에 사용됨
  void _updateNameValidationState() {
    final isValid = _isNameNotEmpty();

    if (_isNameValid != isValid) {
      setState(() => _isNameValid = isValid);
    }
  }

  // 1) 전화번호 입력 완료 시 이름 필드로 이동(다음 단계로 이동)
  void proceedIfPhoneFilled() async {
    final cleanNumber = phoneNumberController.text.replaceAll('-', '');

    // 전화번호 길이가 11 이면서
    // _currentStep == AuthStep.phoneSignup 인 경우
    if (cleanNumber.length == phoneNumberMaxLength && _isPhoneStep) {
      debugPrint(completePhoneNumber);

      // 이름 필드로 이동(다음 단계로 이동)
      setState(() {
        _currentStep = AuthStep.name;
      });
      _nameFocusNode.requestFocus(); // 이름 필드로 포커스 이동
    }

    // 번호가 입력 될때마다 UI 리로드 (suffixIcon 표시에 필요!)
    setState(() {});
  }

  // 2) 이름이 비어있지 않으면 다음 단계로 이동
  void _proceedIfNameFilled() {
    if (_isNameNotEmpty() && _isPhoneNumberNotEmpty) {
      setState(() => _currentStep = AuthStep.birthdate);
      _dateFocusNode.requestFocus();
    } else {
      // 이름 필드에서 다음 단계로 이동 시 전화번호 필드가 비어있으면 전화번호 필드로 포커스 이동
      phoneNumberFocusNode.requestFocus();
    }
  }

  // 3) DatePickerField 입력 값 유효성 검사 및 다음 단계로 이동
  void _proceedIfBirthdaySelected() {
    if (_birthDate != null) {
      setState(() {
        _currentStep = AuthStep.gender;
      });

      _genderFocusNode.requestFocus();
    }
  }

  /// 4) 성별 선택 후, 모든 필드 검증 -> 약관 표시 -> 인증 화면으로 이동
  void _allFieldValidCheck() async {
    final isFormValid = _formKey.currentState?.validate() ?? false;

    if (!isFormValid) return;

    // 전화번호가 가입된 번호면 온보딩 화면으로 pop
    if (isPhoneNumberRegistered()) {
      final result = await showAlertDialog(
        context,
        'This phone number is already registered. Try signing in.',
      );

      if (result != null && mounted) {
        Navigator.of(context).pop();
      }

      return;
    }

    // ✅ 모든 검증 통과
    final phone = completePhoneNumber;
    final name = _nameController.text.trim();
    final birthDate = _birthDate;
    final gender = _selectedGender;

    debugPrint('✅ VERIFIED: $name | $phone | $birthDate | $gender');

    final bool isPop = await showModalBottomSheet(
      context: context,
      barrierColor: AppColors.black26,
      backgroundColor: AppColors.white,
      isScrollControlled: true, // 모달이 화면 높이만큼 채워짐
      // - 하지만 약관 위젯에서 Wrap 위젯 사용해서 내부 요소만큼만 모달이 채워짐
      builder: (context) => const TermsAndConditions(), // 모달 내용: 약관 위젯
    );

    // 약관 통과 시 인증번호 전송
    if (isPop) {
      //TODO: DB에 유저가 입력한 정보 저장
      await sendVerificationCode();
    }
  }

  @override
  AuthType getAuthType() => AuthType.signup;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      bottomSheet:
          (_currentStep == AuthStep.name || _currentStep == AuthStep.gender)
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
                  controller: phoneNumberController,
                  focusNode: phoneNumberFocusNode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
