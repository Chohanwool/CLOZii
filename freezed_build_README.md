freezed 빌드 방법

🔄 빌드가 필요한 경우
  @freezed
  class SignUpState with _$SignUpState {
    const factory SignUpState({
      @Default('') String phoneNumber,
      @Default('') String email,  // ← 새 필드 추가!
    }) = _SignUpState;
  }

  필드 변경 후 → 빌드 필요
  dart run build_runner build --delete-conflicting-outputs

  ---
  💡 개발 팁: Watch 모드

  개발 중에는 watch 모드를 켜놓으면 파일 저장할 때마다 자동으로 재생:

  dart run build_runner watch --delete-conflicting-outputs

  이렇게 하면:
  - ✅ 파일 저장 시 자동으로 감지
  - ✅ 변경된 파일만 재생성 (빠름)
  - ✅ 백그라운드에서 계속 실행

  개발할 때는 터미널 하나 띄워놓고 watch 모드로 실행하고, 코딩하면 편하다!

  ---
  ⚡ 빌드 명령어 비교

  | 명령어   | 용도                     |
  |-------|------------------------|
  | build | 1회성 빌드 (배포 전, 커밋 전)    |
  | watch | 개발 중 자동 빌드 (파일 저장 시마다) |