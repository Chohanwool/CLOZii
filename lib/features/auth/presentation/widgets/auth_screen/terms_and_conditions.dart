import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

enum Age { youth, adult }

/// TODO: 각 약관을 CustomTextLink로 구현해서 상세 약관 페이지로 이동시킬 예정

/// 이용 약관 및 연령 확인 화면 위젯
/// - 전체 동의, 필수 동의, 선택 동의 체크박스 관리
/// - 필수 약관 상세 내용 펼치기 기능
/// - 연령 확인 라디오 버튼과 시작 버튼 포함
class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  // 전체 동의 체크박스 상태
  bool isCheckedAll = false;

  // 필수 약관 동의 체크박스 상태
  bool isMainChecked = false;

  // 선택 약관 동의 체크박스 상태
  bool isOptionalChecked = false;

  // 필수 약관 상세 내용 펼침 여부
  bool isListOpen = false;

  // 연령 확인 라디오 버튼 선택 값 - 기본 값 선택 안됨
  Age? _selectedOption;

  // 18세 이상 인증
  // - 제휴를 통해 통신사 조회 API를 쓰면 18세 이상 여부 확인 가능
  //   한국처럼 표준화된 API가 공개되어 있진 않고, 개별 통신사(Globe, Smart, DITO)와 계약해야 함
  // - SMS 인증으로 본인 번호 확인 → 추가로 신분증 사진 + 셀피 인증 요청
  //   Onfido, Jumio, ShuftiPro, SmileID 같은 외부 KYC 서비스가 API로 제공

  // 	•	서비스사가 법적으로 해야 할 건 “14세 미만 가입 불가”를 약관에 명시하고, 생년월일을 받는 절차 정도.
  // 	•	실제 나이 위변조는 사용자 책임이고, 서비스사는 면책됩니다.
  // 	•	그래서 당근마켓, 쿠팡, 네이버 등도 별도 나이 검증 절차 없이 SMS 인증만으로 운영합니다.

  // ✅ CLOZ 같은 글로벌 서비스도 필리핀 로컬 법률 기준으로:
  // 	•	가입 시 “만 18세 이상만 사용 가능”을 약관에 명시.
  // 	•	사용자 입력 + SMS 인증만으로 처리 → 실제 나이 확인은 안 하지만 법적 책임은 회피 가능.
  Future<void> _onStart() async {
    if (!isMainChecked) {
      showAlertDialog(
        context,
        'You must accept the Terms and Conditions to proceed.',
      );
      return;
    }

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

    Navigator.of(context).pop(true);
  }

  

  /// 전체 동의 토글
  /// - 전체 체크 시 필수/선택 모두 체크
  /// - 전체 체크 해제 시 모두 해제
  void _toggleAll() {
    setState(() {
      isCheckedAll = !isCheckedAll;
      if (isCheckedAll) {
        isMainChecked = true;
        isOptionalChecked = true;
      } else {
        isMainChecked = false;
        isOptionalChecked = false;
      }
    });
  }

  /// 필수 약관 동의 토글
  /// - 필수와 선택 모두 체크되어 있으면 -> 전체 동의 항목도 체크
  /// - 전체 체크 상태에서 필수 항목 체크 해제 시 -> 전체 동의 항목도 체크 해제
  void _toggleMain() {
    setState(() {
      isMainChecked = !isMainChecked;
      if (isMainChecked && isOptionalChecked) {
        isCheckedAll = true;
      } else {
        isCheckedAll = false;
      }
    });
  }

  /// 선택 약관 동의 토글
  /// - 필수와 선택 모두 체크되어 있으면 -> 전체 동의 항목도 체크
  /// - 전체 체크 상태에서 선택 항목 체크 해제 시 -> 전체 동의 항목도 체크 해제
  void _toggleOptional() {
    setState(() {
      isOptionalChecked = !isOptionalChecked;
      if (isMainChecked && isOptionalChecked) {
        isCheckedAll = true;
      } else {
        isCheckedAll = false;
      }
    });
  }

  /// 필수 약관 상세 목록 펼침/접기 토글
  void _openDropDownList() {
    setState(() {
      isListOpen = !isListOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// 모달이 자식만큼만 펼쳐지게 하는 위젯
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 30.0,
            left: 12.0,
            right: 12.0,
          ),
          child: Column(
            children: [
              // 전체 동의 체크박스 + 라벨
              Row(
                children: [
                  // 커스텀 체크 박스 (테두리 O)
                  // TODO: 토글 시 애니메이션 효과 추가
                  IconButton(
                    highlightColor: Colors.transparent,
                    onPressed: _toggleAll,
                    icon: Icon(
                      isCheckedAll
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_off_rounded,
                      color: isCheckedAll
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black87,
                    ),
                  ),
                  Text('Accept All Terms and Conditions'),
                ],
              ),

              Divider(indent: 10.0, endIndent: 20.0),

              // 필수 약관 동의 체크박스 + 라벨 + 펼침 아이콘
              Row(
                children: [
                  // 커스텀 체크 박스 (테두리 X)
                  // TODO: 체크 박스 토글 시 애니메이션 효과 추가
                  // TODO: 드롭다운 아이콘 변경 시 애니메이션 효과 추가
                  // TODO: 드롭다운 애니메이션 효과 추가
                  IconButton(
                    onPressed: _toggleMain,
                    icon: Icon(
                      Icons.check,
                      color: isMainChecked
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Text('(Required) Terms and Conditions'),
                  IconButton(
                    onPressed: _openDropDownList,
                    icon: Icon(
                      isListOpen ? Icons.expand_more : Icons.chevron_right,
                    ),
                  ),
                ],
              ),

              // 필수 약관 상세 내용 펼침 부분
              if (isListOpen)
                Column(
                  children: [
                    Align(
                      alignment: AlignmentGeometry.xy(-0.43, 0),
                      child: Text(
                        '(Required) Terms and Conditions',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: AlignmentGeometry.xy(-0.43, 0),
                      child: Text(
                        '(Required) Terms and Conditions',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 19),
                    Align(
                      alignment: AlignmentGeometry.xy(-0.43, 0),
                      child: Text(
                        '(Required) Terms and Conditions',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                    const SizedBox(height: 7),
                  ],
                ),

              // 선택 약관 동의 체크박스 + 라벨
              Row(
                children: [
                  // 커스텀 체크 박스 (테두리 X)
                  // TODO: 체크 박스 토글 시 애니메이션 효과 추가
                  IconButton(
                    onPressed: _toggleOptional,
                    icon: Icon(
                      Icons.check,
                      color: isOptionalChecked
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  Text('(Optional) Terms and Conditions'),
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
                      child: Text('Verify Your Age'),
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
                      Text('I am 18 years old or above'),
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
                      Text('I am under 18 years old'),
                    ],
                  ),

                  // TODO: 시작 버튼 (앱 메인 페이지로 이동)
                  CustomButton(text: 'Continue', onTap: _onStart),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
