import 'package:flutter/material.dart';

/// 인증번호 타이머 표시 위젯
/// - 남은 분(minutes)과 초(seconds)를 받아  
///   "MM:SS" 형식으로 0을 채워 표시함
class VerificationTimer extends StatelessWidget {
  const VerificationTimer({
    super.key,
    required this.minutes,
    required this.seconds,
  });

  /// 남은 분
  final int minutes;

  /// 남은 초
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Text(
      // 두 자리 숫자로 맞추기 위해 padLeft 사용
      '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
    );
  }
}