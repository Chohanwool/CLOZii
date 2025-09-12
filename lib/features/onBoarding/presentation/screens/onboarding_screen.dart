import 'package:clozii/features/auth/presentation/screens/auth_screen.dart';
import 'package:flutter/material.dart';

// core
import 'package:clozii/features/auth/data/auth_type.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/core/widgets/custom_text_link.dart';

// widgets
// import 'package:clozii/features/auth/presentation/screens/auth_screen.dart';

/// 홈 화면 (앱 시작 시 표시되는 첫 화면)
/// - 로고, 앱 타이틀, 슬로건, 회원가입 버튼, 로그인 링크로 구성
/// - 로그인/회원가입 화면으로 이동하는 네비게이션 기능 포함
class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  /// 로그인 / 회원가입 화면으로 이동하는 메서드
  /// - [authType] 파라미터로 이동할 화면의 타입을 지정
  ///   (AuthType.login → 로그인 화면)
  ///   (AuthType.signup → 회원가입 화면)
  void navigateToAuth(BuildContext context, AuthType authType) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (context) => AuthScreen(authType: authType)),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 화면 중앙 배치
            children: [
              /// 로고 이미지와 앱 슬로건
              const _ImageLogoAndSlogan(),

              const SizedBox(height: 32.0), // 버튼과의 간격
              /// 회원가입 버튼
              /// - 클릭 시 AuthType.signup을 전달하여 회원가입 화면으로 이동
              _SignUpButton(
                // onTap: () => navigateToAuth(context, AuthType.signup),
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (context) => AuthScreen()));
                },
              ),

              /// 로그인 링크
              /// - 클릭 시 AuthType.login을 전달하여 로그인 화면으로 이동
              _LoginPromt(onTap: () => navigateToAuth(context, AuthType.login)),
            ],
          ),
        ),
      ),
    );
  }
}

/// 로고와 슬로건을 표시하는 위젯
/// - 앱 브랜드를 시각적으로 강조
/// - 사이즈를 고정하여 일관성 유지 (디바이스에 따라 사이즈 조정 필요)
class _ImageLogoAndSlogan extends StatelessWidget {
  const _ImageLogoAndSlogan();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/app_logo.png', // 로고 이미지 경로
          width: MediaQuery.of(context).size.width * 3 / 4,
        ),
        const Text(
          'Closer People, Closer Deals', // 앱 슬로건
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

/// 회원가입 버튼 위젯
/// - Flutter 기본 버튼 위젯 대신 CustomButton을 사용하여 자유로운 스타일링 가능
/// - 커스텀 버튼: 아이콘(선택), 텍스트(필수), onTap(필수)
class _SignUpButton extends StatelessWidget {
  const _SignUpButton({required this.onTap});

  /// 버튼 클릭 시 실행할 콜백 함수
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onTap: onTap,
      text: 'Sign Up', // 버튼 라벨
    );
  }
}

/// 로그인 링크 위젯
/// - "이미 계정이 있나요?" 문구와 함께 'Login' 텍스트를 링크처럼 표시
/// - Flutter 기본 제공 링크 위젯이 없기 때문에 CustomTextLink로 구현
/// - 구조: 일반 텍스트(prefix) + 링크 텍스트(linkText)
class _LoginPromt extends StatelessWidget {
  const _LoginPromt({required this.onTap});

  /// 링크 클릭 시 실행할 콜백 함수
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomTextLink(
      prefixText: 'Do you already have an existing account? ', // 안내 문구
      style: const TextStyle(color: Colors.black87), // 일반 텍스트 스타일
      linkText: 'Login', // 링크로 표시할 텍스트
      linkTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary, // 링크 색상
        fontWeight: FontWeight.w500,
      ),
      onTap: onTap,
    );
  }
}
