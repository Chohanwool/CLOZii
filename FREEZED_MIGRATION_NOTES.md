# Freezed 3.0.0 마이그레이션 노트

## 발생한 이슈

```
Missing concrete implementations of 'getter mixin _$User on Object.birthDate',
'getter mixin _$User on Object.createdAt', 'getter mixin _$User on Object.gender',
'getter mixin _$User on Object.isVerified', and 5 more.
```

`lib/features/auth/domain/entities/user.dart` 파일에서 위와 같은 컴파일 오류 발생

## 원인

**Freezed 3.0.0의 Breaking Change**

Freezed 3.0.0부터는 freezed 클래스에 `abstract` 또는 `sealed` 키워드가 필수가 되었습니다.

### 공식 변경사항
- 참고: https://pub.dev/packages/freezed#migration-to-300
- CHANGELOG: https://github.com/rrousselGit/freezed/blob/master/packages/freezed/CHANGELOG.md

주요 변경사항:
1. Freezed 클래스는 반드시 `abstract`, `sealed` 중 하나여야 함
2. `map/when` 메서드 제거 (Dart의 네이티브 패턴 매칭 사용 권장)
3. `with _$MyClass` 누락 시 빌드 오류 발생

## 해결 방법

### Before (잘못된 코드)
```dart
@freezed
class User with _$User {  // ❌ freezed 3.0.0에서 오류 발생
  const factory User({
    required String uid,
    required String name,
    // ...
  }) = _User;
}
```

### After (수정된 코드)
```dart
@freezed
sealed class User with _$User {  // ✅ sealed 키워드 추가
  const factory User({
    required String uid,
    required String name,
    // ...
  }) = _User;
}
```

## sealed vs abstract 선택 기준

### `sealed class` 사용 (권장)
- **제한된 하위 타입**: 같은 파일 내에서만 상속 가능
- **패턴 매칭 최적화**: switch문에서 모든 케이스 처리 여부를 컴파일러가 체크
- **Union Types**: 여러 variant를 가진 타입 (예: Result, State 등)

```dart
@freezed
sealed class Result with _$Result {
  const factory Result.success(String data) = Success;
  const factory Result.error(String message) = Error;
  const factory Result.loading() = Loading;
}

// 컴파일러가 모든 케이스 처리 여부를 체크
void handle(Result result) {
  switch (result) {
    case Success(:final data): /* ... */
    case Error(:final message): /* ... */
    case Loading(): /* ... */
    // 하나라도 빠뜨리면 컴파일 에러!
  }
}
```

### `abstract class` 사용
- **확장 가능**: 다른 파일에서도 상속 가능
- **단순 데이터 클래스**: variant 없이 하나의 생성자만 있을 때
- **기존 코드 호환성**: 기존 abstract class 패턴 유지

```dart
@freezed
abstract class User with _$User {
  const factory User({
    required String uid,
    required String name,
  }) = _User;
}
```

## 프로젝트 전체 마이그레이션 체크리스트

- [x] `lib/features/auth/domain/entities/user.dart` - sealed 적용 완료
- [ ] 다른 freezed 클래스가 있는지 확인
  ```bash
  # freezed 사용 파일 찾기
  grep -r "@freezed" lib/
  ```
- [ ] 각 파일에 `sealed` 또는 `abstract` 키워드 추가
- [ ] `flutter pub run build_runner build --delete-conflicting-outputs` 실행
- [ ] 테스트 실행하여 정상 동작 확인

## 추가 작업 필요 시

### map/when 메서드 사용하던 코드가 있다면

**Before (freezed 2.x)**
```dart
result.when(
  success: (data) => print(data),
  error: (msg) => print(msg),
  loading: () => print('loading'),
);
```

**After (freezed 3.x - Dart 패턴 매칭 사용)**
```dart
switch (result) {
  case Success(:final data):
    print(data);
  case Error(:final message):
    print(message);
  case Loading():
    print('loading');
}
```

## 현재 프로젝트 환경

```yaml
dependencies:
  freezed_annotation: ^3.1.0

dev_dependencies:
  freezed: ^3.2.3
  build_runner: ^2.7.1
  json_serializable: ^6.11.1
```

## 참고 자료

- [Freezed 공식 문서](https://pub.dev/packages/freezed)
- [마이그레이션 가이드](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/migration_guide.md)
- [CHANGELOG 3.0.0](https://github.com/rrousselGit/freezed/blob/master/packages/freezed/CHANGELOG.md#300---2025-02-25)

---

**작성일**: 2025-11-18
**해결 완료**: ✅
