import 'package:flutter/material.dart';

// APIs
import 'package:flutter_riverpod/flutter_riverpod.dart';

// core
import 'package:clozii/core/theme/context_extension.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/verification/verification_field.dart';

// providers
import 'package:clozii/features/auth/presentation/providers/sign_up_provider.dart';
import 'package:clozii/features/auth/presentation/providers/verification_provider.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // 화면이 렌더링 된 후 타이머 시작
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(verificationProvider.notifier)
          .startCooldownTimer(totalSeconds: 30);
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpNotifier = ref.read(signUpProvider.notifier);
    final vState = ref.watch(verificationProvider);
    final vNotifier = ref.read(verificationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            signUpNotifier.resetAgreements();
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

                          // 인증번호 재전송
                          await signUpNotifier.sendVerificationCode();

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
