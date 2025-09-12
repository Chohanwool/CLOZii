import 'dart:async';

import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/animation.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/features/auth/presentation/widgets/verification_field.dart';
import 'package:clozii/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  /// 인증번호 유효 시간 - 타이머
  Timer? _timer;
  int _minutes = 1;
  int _seconds = 0;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() async {
      if (_controller.text.length == 6 && _isValidCode()) {
        final loading = showLoadingOverlay(context); // ⬅️ 현재 화면 위에 로딩만 띄움

        try {
          // 이미 계정이 존재하는 지 확인
          // 없으면 -> 새로 생성
          // 있으면 -> 로그인
          await Future.delayed(const Duration(seconds: 2)); // 예시

          if (!mounted) return;

          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            fadeInRoute(HomeScreen()),
            (route) => false, // 스택 전부 제거
          );
        } finally {
          loading.remove();
        }
      }
    });

    _startTimer();
  }

  @override
  void dispose() {
    // 타이머 해제
    if (_timer != null) _timer!.cancel();

    _controller.dispose();
    super.dispose();
  }

  // SMS 인증번호 검증 - 아마 Future<bool> 로 변경해야 할것 같다
  bool _isValidCode() {
    if (_controller.text == '123123') {
      return true;
    }
    return false;
  }

  /// 인증번호 유효시간 카운트다운 시작
  void _startTimer() {
    // 기존 타이머가 동작 중이면 취소
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    // 초기값 1분
    _minutes = 1;
    _seconds = 0;

    // 타이머 초기화 - Timer.periodic (일정 주기마다 특정 로직 수행)
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (!mounted) return; // 화면이 사라진 상태라면 아무것도 안 함

        if (_seconds > 0) {
          _seconds--;
        } else {
          _minutes--;
          _seconds = 59;
        }
      });

      // 시간이 다 되면 타이머 종료
      if (_minutes == 0 && _seconds == 0) {
        timer.cancel();
      }
    });
  }

  /// 인증번호 요청 횟수 제한 관리
  /// - SharedPreferences를 사용해 앱 종료 후에도 횟수 저장
  /// - 1분(임시) 동안 최대 5회 제한 (현재 전화번호 구분 로직은 구현 안함)
  Future<int> _requestCodeCount() async {
    final requestCooldown = Duration(minutes: 3).inMilliseconds; // 제한 시간 1분
    final prefs = await SharedPreferences.getInstance(); // 네이티브 저장소 연결
    final now = DateTime.now().millisecondsSinceEpoch; // 메서드가 호출된 시간 (밀리초)

    int firstRequestTime =
        prefs.getInt('firstRequestTime') ?? 0; // 제한 횟수 5회 중 첫번째로 요청한 시각
    int countRemaining = prefs.getInt('countRemaining') ?? 5; // 남은 제한 횟수
    int diff = now - firstRequestTime; // 메서드가 호출된 시간 - 첫 인증번호 요청 시간

    // 1분이 지났으면 횟수 초기화
    if (diff > requestCooldown) {
      await prefs.setInt('firstRequestTime', now); // 제한 시간이 지나면 첫 요청 시간 갱신
      countRemaining = 5; // 요청 횟수 카운트도 초기화
    }

    // 핵심 로직‼️
    // 남은 횟수 감소 후 저장
    countRemaining--;
    await prefs.setInt('countRemaining', countRemaining);

    return countRemaining;
  }

  /// "인증번호 전송" 버튼 클릭 처리
  void _onSendCodeButtonPressed() async {
    int count = await _requestCodeCount(); // 요청 제한 횟수 카운트
    if (count > 0) {
      _startTimer(); // 타이머 시작
    }

    // TODO: 실제 인증번호 전송 로직 구현
    // TODO: count < 0 이면 전송 차단
    // TODO: 전송된 인증번호를 상태에 저장해 검증 시 사용

    setState(() {
      // 스낵바 내용 :
      // - 최초 요청 시 "인증번호 전송됨" 메시지 표시 - "Verfication code sent."
      Widget content = Text('Verification code sent.');

      // - 제한 횟수가 남아 있는 경우, 남은 요청 가능 횟수 표시 - "N verfication attems remaining."
      if (count >= 0) {
        content = Text('$count verification attemps remaining.');
      }

      // - 제한 횟수를 초과한 경우 "나중에 다시 시도해주세요" 표시 - "Try again later."
      if (count < 0) {
        content = Text('Try again later');
      }

      // 기존 스낵바 제거 - 기존 스낵바가 제거되기 전에 다시 스낵바가 호출될 경우를 대비
      ScaffoldMessenger.of(context).clearSnackBars();

      // 새 스낵바 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(20.0),
          ),

          // 스낵바 내용
          content: content,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please enter the verification code',
                style: context.textTheme.titleLarge,
              ),

              const SizedBox(height: 24),

              VerificationField(
                minutes: _minutes,
                seconds: _seconds,
                onVerified: () {},
                controller: _controller,
              ),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                  style: TextButton.styleFrom(
                    overlayColor: Colors.grey,
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 12.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4.0),
                    ),
                  ),
                  onPressed: _onSendCodeButtonPressed,
                  child: Text(
                    'Send code again',
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.colors.scrim,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
