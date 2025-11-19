# CLOZii TODO List

## 🔐 Auth / 회원가입 개선

### [ ] Firebase Auth 에러 처리 개선

**우선순위: 높음 (High)**

**배경:**
현재 회원가입 과정에서 발생하는 Firebase Auth 에러들을 구체적으로 처리하지 않고 있어, 사용자가 정확한 오류 원인을 알 수 없음.

**개선 필요 사항:**

#### 1. `verifyCode()` 메서드 개선 (가장 시급)
- **파일:** `lib/features/auth/data/repositories/auth_repository_impl.dart`
- **현재 문제:** 모든 에러를 `UnknownFailure`로만 처리 (line 150-152)
- **개선 내용:**
  ```dart
  // 현재
  } catch (e) {
    return AuthResult.failure(UnknownFailure(e.toString()));
  }

  // 개선 후
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'invalid-verification-code':
        return AuthResult.failure(InvalidVerificationCodeFailure('잘못된 인증번호입니다.', e.code));
      case 'session-expired':
        return AuthResult.failure(VerificationCodeExpiredFailure('인증번호가 만료되었습니다.', e.code));
      case 'credential-already-in-use':
        return AuthResult.failure(PhoneAlreadyRegisteredFailure('이미 가입된 번호입니다.', e.code));
      case 'network-request-failed':
        return AuthResult.failure(NetworkFailure('네트워크 연결을 확인해주세요.', e.code));
      default:
        return AuthResult.failure(AuthenticationFailure(e.message ?? '인증 실패', e.code));
    }
  } catch (e) {
    return AuthResult.failure(UnknownFailure(e.toString()));
  }
  ```

#### 2. `sendVerificationCode()` 메서드 개선
- **파일:** `lib/features/auth/data/repositories/auth_repository_impl.dart`
- **현재 문제:** 모든 `FirebaseAuthException`을 `AuthenticationFailure`로만 처리 (line 99-106)
- **개선 내용:**
  ```dart
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'quota-exceeded':
      case 'too-many-requests':
        return AuthResult.failure(MaxAttemptsReachedFailure('SMS 전송 한도를 초과했습니다.', e.code));
      case 'invalid-phone-number':
      case 'missing-phone-number':
        return AuthResult.failure(ValidationFailure('올바른 전화번호를 입력해주세요.', e.code));
      case 'network-request-failed':
        return AuthResult.failure(NetworkFailure('네트워크 연결을 확인해주세요.', e.code));
      default:
        return AuthResult.failure(AuthenticationFailure(e.message ?? 'Firebase auth error occurred', e.code));
    }
  }
  ```

#### 3. UI 개선 (선택사항)
- **파일:** `lib/features/auth/presentation/verification/verification_provider.dart`
- **개선 내용:** Failure 타입에 따라 다른 UI 피드백 제공
  - `InvalidVerificationCodeFailure`: 인증번호 필드 shake 애니메이션
  - `VerificationCodeExpiredFailure`: 재전송 버튼 강조
  - `NetworkFailure`: 네트워크 확인 안내
  - `PhoneAlreadyRegisteredFailure`: 로그인 화면으로 이동 제안

**관련 파일:**
- `lib/features/auth/data/repositories/auth_repository_impl.dart` (line 99-152)
- `lib/features/auth/core/errors/auth_failures.dart`
- `lib/features/auth/presentation/verification/verification_provider.dart`
- `lib/features/auth/domain/usecases/verify_otp_code.dart`

**예상 작업 시간:** 1-2시간

**테스트 시나리오:**
1. ✅ 잘못된 인증번호 입력 시 명확한 오류 메시지
2. ✅ 인증번호 만료 시 재전송 유도
3. ✅ 네트워크 오류 시 재시도 유도
4. ✅ SMS 할당량 초과 시 안내

---

## 📝 참고사항

- 이 파일은 프로젝트의 TODO 및 개선사항을 관리합니다
- 작업 완료 시 `[ ]`를 `[x]`로 변경해주세요
- 새로운 TODO 항목은 이 파일에 계속 추가됩니다