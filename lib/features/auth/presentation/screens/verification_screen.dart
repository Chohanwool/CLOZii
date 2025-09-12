import 'dart:async';

import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/utils/animation.dart';
import 'package:clozii/core/utils/show_alert_dialog.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:clozii/features/auth/presentation/screens/auth_screen.dart';
import 'package:clozii/features/auth/presentation/widgets/verification/verification_field.dart';
import 'package:clozii/features/home/presentation/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  // FirebaseAuth 관련 상태 값
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  bool _isLoading = false;
  String? _errorMessage;

  /// 인증번호 유효 시간 - 타이머
  Timer? _timer;
  int _minutes = 1;
  int _seconds = 0;

  int _failedAttemps = 0;

  final TextEditingController _optController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 화면 들어오면 인증번호 요청
    debugPrint('phoneNumber: ${widget.phoneNumber}');

    _phoneLogin(widget.phoneNumber);

    _startTimer();
  }

  @override
  void dispose() {
    // 타이머 해제
    if (_timer != null) _timer!.cancel();

    _optController.dispose();
    super.dispose();
  }

  // Firebase 인증 핵심 로직
  Future<void> _phoneLogin(String phoneNumber) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,

        // Android 기기의 SMS 코드 자동 처리
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await _auth.signInWithCredential(credential);
        },

        // 잘못된 전화번호나 SMS 할당량 초과 여부 등의 실패 이벤트 처리
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
            _errorMessage = '인증번호 발송 실패: ${e.message}';
          });

          // 상세한 오류 정보 출력
          debugPrint('=== Firebase Auth Error ===');
          debugPrint('Error Code: ${e.code}');
          debugPrint('Error Message: ${e.message}');
          debugPrint('Error Details: ${e.toString()}');
          debugPrint('=======================');
        },

        // Firebase에서 기기로 코드가 전송된 경우를 처리하며 사용자에게 코드을 입력하라는 메시지를 표시
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          debugPrint('=== codeSent ===');
          debugPrint('verificationId: $verificationId');

          setState(() {
            _verificationId = verificationId;
            _isLoading = false;
          });
        },

        // 자동 SMS 코드 처리에 실패한 경우 시간 초과를 설정
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false;
            _errorMessage = '인증번호 발송 실패: 인증번호 처리 시간 초과';
          });
        },
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '오류가 발생했습니다: ${e.toString()}';
      });
    }
  }

  // SMS 인증번호 검증 - 아마 Future<bool> 로 변경해야 할것 같다
  void _isValidCode() {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _optController.text,
    );
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

  Future<void> _handleCodeSubmit() async {
    final loading = showLoadingOverlay(context);
    bool removed = false;

    try {
      await Future.delayed(const Duration(milliseconds: 300)); // 예시 처리
      if (!mounted) return;

      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: _optController.text,
        );

        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);

        User? user = userCredential.user;

        if (user != null) {
          debugPrint('로그인 성공: ${user.phoneNumber}');
        }
      } catch (e) {
        debugPrint('로그인 실패: ${e}');

        if (_failedAttemps == 2) {
          if (mounted) {
            removed = true;
            loading.remove();
            ScaffoldMessenger.of(context).clearSnackBars();

            final result = await showAlertDialog(
              context,
              title: 'Verfication Failed',
              'You have attempted verification too many times. Please try again later.',
            );

            if (result != null) {
              if (mounted) {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  fadeInRoute(AuthScreen()),
                  (route) => route.isFirst,
                );
              }
            }
          }
        }
        _failedAttemps++;

        if (mounted) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20.0),
                ),
                content: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Verification code does not match.'),
                    SizedBox(height: 5.0),
                    Text('Please try again.'),
                  ],
                ),
              ),
            );
        }
      }
    } finally {
      if (!removed) loading.remove();
    }
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
                controller: _optController,
                onChanged: (value) async {
                  // optCode 6자리 입력시 자동 호출
                  if (value.length == 6) {
                    await _handleCodeSubmit();
                  }
                },
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
