import 'package:flutter/material.dart';

// core
import 'package:clozii/features/auth/core/enum/auth_step.dart';

// states
import 'package:clozii/features/auth/presentation/states/sign_up_state.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/forms/fields/gender_dropdown_field.dart';
import 'package:clozii/features/auth/presentation/widgets/forms/fields/date_picker_field.dart';
import 'package:clozii/features/auth/presentation/widgets/forms/fields/name_field.dart';
import 'package:clozii/features/auth/presentation/widgets/forms/fields/phone_number_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.signUpState,
    required this.onPhoneChanged,
    required this.onNameChanged,
    required this.onBirthDateChanged,
    required this.onGenderChanged,
    required this.phoneNumberFocusNode,
    required this.nameFocusNode,
    required this.birthDateFocusNode,
    required this.genderFocusNode,
  });

  final SignUpState signUpState;
  final ValueChanged<String> onPhoneChanged;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<DateTime?> onBirthDateChanged;
  final ValueChanged<String?> onGenderChanged;
  final FocusNode phoneNumberFocusNode;
  final FocusNode nameFocusNode;
  final FocusNode birthDateFocusNode;
  final FocusNode genderFocusNode;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // 입력 필드 컨트롤러
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.signUpState.phoneNumber;
    _nameController.text = widget.signUpState.name;
    if (widget.signUpState.birthDate != null) {
      _dateController.text = widget.signUpState.birthDate!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }

  /// 아래에서 위로 입력필드가 순서에 맞게 노출되는 방식
  /// 순서) 연락처 -> 이름(별명) -> 생년월일 -> 성별
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.signUpState.currentStep.index >= AuthStep.gender.index) ...[
          GenderDropdownField(
            focusNode: widget.genderFocusNode,
            selectedGender: widget.signUpState.gender,
            onChanged: widget.onGenderChanged,
          ),
          const SizedBox(height: 24.0),
        ],

        if (widget.signUpState.currentStep.index >=
            AuthStep.birthdate.index) ...[
          DatePickerField(
            controller: _dateController,
            focusNode: widget.birthDateFocusNode,
            onChanged: widget.onBirthDateChanged,
          ),
          const SizedBox(height: 24.0),
        ],

        if (widget.signUpState.currentStep.index >= AuthStep.name.index) ...[
          NameField(
            controller: _nameController,
            focusNode: widget.nameFocusNode,
            onChanged: widget.onNameChanged,
          ),
          const SizedBox(height: 24.0),
        ],

        PhoneNumberField(
          controller: _phoneController,
          focusNode: widget.phoneNumberFocusNode,
          onChanged: widget.onPhoneChanged,
        ),
      ],
    );
  }
}
