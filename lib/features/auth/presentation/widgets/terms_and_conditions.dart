import 'package:flutter/material.dart';

// core
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/features/auth/core/enum/agreement_type.dart';

// Libraries
import 'package:flutter_riverpod/flutter_riverpod.dart';

// providers
import 'package:clozii/features/auth/presentation/providers/sign_up_provider.dart';

enum Age { youth, adult }

/// TODO: 각 약관을 CustomTextLink로 구현해서 상세 약관 페이지로 이동시킬 예정

/// 이용 약관 및 연령 확인 화면 위젯
/// - 전체 동의, 필수 동의, 선택 동의 체크박스 관리
/// - 필수 약관 상세 내용 펼치기 기능
/// - 연령 확인 라디오 버튼과 시작 버튼 포함
class TermsAndConditions extends ConsumerStatefulWidget {
  const TermsAndConditions({super.key, required this.onShowAgreementDetail});

  final Function(AgreementType) onShowAgreementDetail;

  @override
  ConsumerState<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends ConsumerState<TermsAndConditions> {
  // 연령 확인 라디오 버튼 선택 값 - 기본 값 선택 안됨
  Age? _selectedOption;

  Future<void> _onSubmit() async {
    // if (!isMainChecked) {
    //   showAlertDialog(
    //     context,
    //     'You must accept the Terms and Conditions to proceed.',
    //   );
    //   return;
    // }

    if (_selectedOption == Age.youth) {
      showAlertDialog(
        context,
        'You must be at least 18 years old to use this app.',
      );
      return;
    }

    if (_selectedOption == null) {
      showAlertDialog(context, 'You need to verify your age!');
      return;
    }

    // 약관 동의 후 모달 닫기
    // return true
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpProvider);
    final signUpNotifier = ref.read(signUpProvider.notifier);

    /// 모달이 자식만큼만 펼쳐지게 하는 위젯
    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 30.0,
          left: 12.0,
          right: 12.0,
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 전체 동의 체크박스 + 라벨
              Row(
                children: [
                  // 커스텀 체크 박스 (테두리 O)
                  // TODO: 토글 시 애니메이션 효과 추가
                  IconButton(
                    highlightColor: Colors.transparent,
                    onPressed: () => signUpNotifier.toggleAllAgreement(),
                    icon: Icon(
                      signUpState.isAllAgreed
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_off_rounded,
                      color: signUpState.isAllAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black87,
                    ),
                  ),
                  const Text('Accept All Terms and Conditions'),
                ],
              ),

              Divider(indent: 10.0, endIndent: 20.0),

              // TODO: 공통사항
              // 커스텀 체크 박스 (테두리 X)
              // TODO: 체크 박스 토글 시 애니메이션 효과 추가
              // TODO: 드롭다운 아이콘 변경 시 애니메이션 효과 추가
              // TODO: 드롭다운 애니메이션 효과 추가

              // 필수 약관 동의 체크박스 + 라벨 + 펼침 아이콘
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final newValue = !signUpState.isTermAgreed;
                      signUpNotifier.updateIndividualAgreement(
                        isTermAgreed: newValue,
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: signUpState.isTermAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(child: const Text('(Required) Terms of Service')),
                  IconButton(
                    onPressed: () =>
                        widget.onShowAgreementDetail(AgreementType.terms),
                    icon: Icon(Icons.expand_more),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final newValue = !signUpState.isPrivacyPolicyAgreed;
                      signUpNotifier.updateIndividualAgreement(
                        isPrivacyPolicyAgreed: newValue,
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: signUpState.isPrivacyPolicyAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(child: const Text('(Required) Privacy Policy')),
                  IconButton(
                    onPressed: () =>
                        widget.onShowAgreementDetail(AgreementType.privacy),
                    icon: Icon(Icons.expand_more),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final newValue = !signUpState.isLocationPolicyAgreed;
                      signUpNotifier.updateIndividualAgreement(
                        isLocationPolicyAgreed: newValue,
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: signUpState.isLocationPolicyAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(
                    child: const Text('(Required) Location Access Consent'),
                  ),
                  IconButton(
                    onPressed: () =>
                        widget.onShowAgreementDetail(AgreementType.location),
                    icon: Icon(Icons.expand_more),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final newValue = !signUpState.isMarketingAgreed;
                      signUpNotifier.updateIndividualAgreement(
                        isMarketingAgreed: newValue,
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: signUpState.isMarketingAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(
                    child: const Text(
                      '(Optional) Marketing and Promotional Consent',
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        widget.onShowAgreementDetail(AgreementType.marketing),
                    icon: Icon(Icons.expand_more),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final newValue = !signUpState.isThirdPartyAgreed;
                      signUpNotifier.updateIndividualAgreement(
                        isThirdPartyAgreed: newValue,
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: signUpState.isThirdPartyAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(
                    child: const Text(
                      '(Optional) Third-party Data Sharing Consent',
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                        widget.onShowAgreementDetail(AgreementType.thirdParty),
                    icon: Icon(Icons.expand_more),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final newValue = !signUpState.isPushAgreed;
                      signUpNotifier.updateIndividualAgreement(
                        isPushAgreed: newValue,
                      );
                    },
                    icon: Icon(
                      Icons.check,
                      color: signUpState.isPushAgreed
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Expanded(
                    child: const Text('(Optional) Push Notification Consent'),
                  ),
                  IconButton(
                    onPressed: () =>
                        widget.onShowAgreementDetail(AgreementType.push),
                    icon: Icon(Icons.expand_more),
                  ),
                ],
              ),

              Divider(indent: 10.0, endIndent: 20.0),

              // 연령 확인 섹션 타이틀
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 13.0,
                        top: 13.0,
                        bottom: 5.0,
                      ),
                      child: const Text('Verify Your Age'),
                    ),
                  ),

                  // 18세 이상 라디오 버튼
                  Row(
                    children: [
                      Radio<Age>(
                        value: Age.adult,
                        groupValue: _selectedOption, // 모든 라디오 버튼이 공유하는 필드
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            // 라디오 버튼의 공유 필드가 나의 value 와 일치하면 선택된 것 ✅
                            _selectedOption = value;
                          });
                        },
                      ),
                      const Text('I am 18 years old or above'),
                    ],
                  ),

                  // 18세 미만 라디오 버튼
                  Row(
                    children: [
                      Radio<Age>(
                        value: Age.youth,
                        groupValue: _selectedOption, // 모든 라디오 버튼이 공유하는 필드
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            // 라디오 버튼의 공유 필드가 나의 value 와 일치하면 선택된 것 ✅
                            _selectedOption = value;
                          });
                        },
                      ),
                      const Text('I am under 18 years old'),
                    ],
                  ),

                  const SizedBox(height: 12.0),

                  // 제출 버튼
                  CustomButton(text: 'Continue', onTap: _onSubmit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
