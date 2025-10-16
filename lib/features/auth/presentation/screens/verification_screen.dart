import 'package:flutter/material.dart';
import 'dart:async';

// core
import 'package:clozii/core/theme/context_extension.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/verification/verification_field.dart';

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

  // int _failedAttemps = 0;

  final TextEditingController _optController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    if (_timer != null) _timer!.cancel();

    _optController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Please enter the verification code',
                style: context.textTheme.titleLarge,
              ),

              const SizedBox(height: 24.0),

              VerificationField(
                minutes: _minutes,
                seconds: _seconds,
                onVerified: () {},
                controller: _optController,
                onChanged: (value) async {
                  // optCode 6자리 입력 완료시 자동 호출
                  if (value.length == 6) {
                    debugPrint('code 확인 작업 호출');
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
                  onPressed: () {},
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
