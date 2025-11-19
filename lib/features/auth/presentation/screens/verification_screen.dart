import 'package:clozii/core/utils/show_loading_overlay.dart';
import 'package:flutter/material.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// core
import 'package:clozii/core/theme/context_extension.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/verification/verification_field.dart';

// providers
import 'package:clozii/features/auth/presentation/sign_up/sign_up_provider.dart';
import 'package:clozii/features/auth/presentation/sign_in/sign_in_provider.dart';
import 'package:clozii/features/auth/presentation/verification/verification_provider.dart';

// enum
import 'package:clozii/features/auth/core/enum/verification_mode.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({
    super.key,
    this.mode = VerificationMode.signUp,
  });

  final VerificationMode mode;

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  OverlayEntry? _loadingOverlay;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 화면이 렌더링 된 후 타이머 시작 및 모드 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(verificationProvider.notifier).setMode(widget.mode);
      ref
          .read(verificationProvider.notifier)
          .startCooldownTimer(totalSeconds: 30);
    });
  }

  @override
  void dispose() {
    _loadingOverlay?.remove();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpNotifier = ref.read(signUpProvider.notifier);
    final signInNotifier = ref.read(signInProvider.notifier);
    final vState = ref.watch(verificationProvider);
    final vNotifier = ref.read(verificationProvider.notifier);

    /// 로딩 오버레이 추가/제거
    ref.listen<VerificationState>(verificationProvider, (previous, next) {
      if (previous?.isLoading != next.isLoading) {
        if (next.isLoading) {
          _loadingOverlay = showLoadingOverlay(context);
        } else {
          _loadingOverlay?.remove();
          _loadingOverlay = null;
        }
      }

      // 심각한 오류 발생 시 오류 모달 표시 후 회원가입 처음으로 이동
      if (next.hasCriticalError && previous?.hasCriticalError == false) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('오류'),
            content: Text(next.errorMessage ?? '예기치 않은 오류가 발생했습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  // 다이얼로그 닫기
                  Navigator.of(context).pop();
                  // 회원가입 상태 초기화
                  signUpNotifier.resetAll();
                  // 회원가입 첫 화면으로 이동 (현재 스택 모두 제거)
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('확인'),
              ),
            ],
          ),
        );
      }

      // 인증 성공 시 홈 화면으로 이동
      // - 회원가입 완료
      if (next.isSuccess && previous?.isSuccess == false) {
        // 모든 스택 제거하고 홈 화면으로 이동
        // FirebaseAuth의 authStateChanges()가 자동으로 감지하여 HomeScreen을 표시함
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // mode에 따라 다른 상태 초기화
            if (widget.mode == VerificationMode.signUp) {
              signUpNotifier.resetAgreements();
            } else {
              signInNotifier.reset();
            }
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
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
                minutes: vState.minutes,
                seconds: vState.seconds,
                onVerified: () {},
                controller: _otpController,
                onChanged: vNotifier.updateOtpCode,
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
                  onPressed: vState.canResend
                      ? () async {
                          // attemptCount 증가
                          vNotifier.updateAttemptCount();

                          // 인증번호 재전송 (mode에 따라 다른 provider 사용)
                          if (widget.mode == VerificationMode.signUp) {
                            await signUpNotifier.sendVerificationCode();
                          } else {
                            await signInNotifier.sendVerificationCode();
                          }

                          // 타이머 시작
                          ref
                              .read(verificationProvider.notifier)
                              .startCooldownTimer(totalSeconds: 30);
                        }
                      : () {
                          if (vState.attemptCount >= 3) {
                            debugPrint('너무 많은 요청으로 실패!!');
                          } else {
                            debugPrint('전송 불가능!!');
                            debugPrint('vState.canResend: ${vState.canResend}');
                          }
                        },
                  child: Text(
                    'Send code again',
                    style: context.textTheme.labelLarge!.copyWith(
                      color: context.colors.primary,
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
