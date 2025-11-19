import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// core
import 'package:clozii/core/theme/context_extension.dart';
import 'package:clozii/core/widgets/custom_button.dart';
import 'package:clozii/core/utils/show_loading_overlay.dart';

// providers
import 'package:clozii/features/auth/presentation/providers/sign_in/sign_in_provider.dart';

// widgets
import 'package:clozii/features/auth/presentation/widgets/forms/fields/phone_number_field.dart';

// screens
import 'package:clozii/features/auth/presentation/screens/verification_screen.dart';

// enum
import 'package:clozii/features/auth/core/enum/verification_mode.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  OverlayEntry? _loadingOverlay;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 포커스 자동 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(signInProvider.notifier).phoneNumberFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _loadingOverlay?.remove();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInProvider);
    final signInNotifier = ref.read(signInProvider.notifier);

    // 로딩 오버레이 추가/제거
    ref.listen<SignInState>(signInProvider, (previous, next) {
      if (previous?.isLoading != next.isLoading) {
        if (next.isLoading) {
          _loadingOverlay = showLoadingOverlay(context);
        } else {
          _loadingOverlay?.remove();
          _loadingOverlay = null;
        }
      }
    });

    // 인증번호 전송 성공 시 VerificationScreen으로 이동
    ref.listen<SignInState>(signInProvider, (previous, next) {
      if (previous?.isSuccess != next.isSuccess && next.isSuccess) {
        if (next.verificationId != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const VerificationScreen(
                mode: VerificationMode.signIn,
              ),
            ),
          );
        }
      }
    });

    // 에러 메시지 표시
    ref.listen<SignInState>(signInProvider, (previous, next) {
      if (next.errorMessage != null && previous?.errorMessage != next.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: signInNotifier.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  'Welcome back!',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your phone number to sign in',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 32),

                // 전화번호 입력 필드
                PhoneNumberField(
                  controller: _phoneController,
                  focusNode: signInNotifier.phoneNumberFocusNode,
                  onChanged: signInNotifier.updatePhoneNumber,
                ),

                const Spacer(),

                // Continue 버튼
                CustomButton(
                  onTap: signInState.isPhoneValid && !signInState.isLoading
                      ? () async {
                          if (signInNotifier.formKey.currentState?.validate() ?? false) {
                            await signInNotifier.sendVerificationCode();
                          }
                        }
                      : null,
                  text: 'Continue',
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
