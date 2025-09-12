# 🤖 Auto Commit Script - CLOZii 프로젝트

## 📋 개요

`auto_commit.sh`는 Git 변경사항을 자동으로 분석하여 적절한 커밋 메시지를 생성하는 스크립트입니다. Flutter/Dart 프로젝트에 특화되어 있으며, 파일 타입과 경로를 기반으로 의미있는 커밋 메시지를 자동 생성합니다.

## ✨ 주요 기능

- 🔍 **자동 파일 분석**: 변경된 파일들을 스마트하게 분석
- 📝 **커밋 메시지 생성**: Conventional Commits 형식으로 메시지 생성
- 🎯 **Flutter 특화**: Dart, Android, iOS 파일 타입별 최적화
- 🚀 **원클릭 실행**: 간단한 명령어로 자동 커밋

## 🛠️ 설치 및 설정

### 1. 스크립트 권한 설정
```bash
chmod +x auto_commit.sh
```

### 2. 실행 권한 확인
```bash
ls -la auto_commit.sh
# 출력: -rwxr-xr-x (x가 있어야 실행 가능)
```

## 📖 사용법

### 기본 사용법

#### **방법 1: 직접 실행 (추천)**
```bash
# 변경사항 스테이징
git add .

# 자동 커밋 메시지로 커밋
git commit -m "$(./auto_commit.sh)"
```

#### **방법 2: 단계별 실행**
```bash
# 1. 스크립트 실행하여 메시지 확인
./auto_commit.sh

# 2. 생성된 메시지를 복사하여 커밋
git commit -m "feat: 메인 앱 설정 변경"
```

#### **방법 3: 특정 파일만 커밋**
```bash
# 특정 파일만 스테이징
git add lib/main.dart

# 자동 커밋
git commit -m "$(./auto_commit.sh)"
```

## 🎯 커밋 메시지 패턴

### Dart 파일 분석
| 파일 경로 | 생성되는 커밋 메시지 |
|-----------|---------------------|
| `lib/features/auth/` | `feat(auth): auth 기능 구현` |
| `lib/features/home/` | `feat(home): home 기능 구현` |
| `lib/core/` | `feat(core): 핵심 기능 구현` |
| `lib/main.dart` | `feat: 메인 앱 설정 변경` |
| 기타 `.dart` 파일 | `feat: Dart 코드 변경` |

### 플랫폼별 분석
| 파일 타입 | 생성되는 커밋 메시지 |
|-----------|---------------------|
| `android/`, `.gradle`, `.kts` | `feat(android): Android 플랫폼 설정` |
| `ios/`, `.pbxproj`, `.plist` | `feat(ios): iOS 플랫폼 설정` |

### 설정 및 리소스 파일
| 파일 타입 | 생성되는 커밋 메시지 |
|-----------|---------------------|
| `pubspec.yaml`, `firebase.json` | `chore: 프로젝트 설정 및 의존성 업데이트` |
| `assets/`, `.png`, `.jpg`, `.svg` | `feat(assets): 리소스 파일 추가/수정` |

## 📊 실행 예시

### 예시 1: Feature 브랜치 개발
```bash
$ git add lib/features/auth/presentation/screens/auth_screen.dart
$ ./auto_commit.sh

🔍 변경된 파일들을 분석중...
📁 변경된 파일들:
lib/features/auth/presentation/screens/auth_screen.dart

🤖 자동 생성된 커밋 메시지:
feat(auth): auth 기능 구현

💡 사용법:
git commit -m "$(./auto_commit.sh)"

또는 직접 복사해서 사용하세요!
```

### 예시 2: Firebase 설정
```bash
$ git add android/app/google-services.json pubspec.yaml
$ ./auto_commit.sh

🔍 변경된 파일들을 분석중...
📁 변경된 파일들:
android/app/google-services.json
pubspec.yaml

🤖 자동 생성된 커밋 메시지:
feat(android): Android 플랫폼 설정

💡 사용법:
git commit -m "$(./auto_commit.sh)"

또는 직접 복사해서 사용하세요!
```

### 예시 3: 리소스 파일 추가
```bash
$ git add assets/images/new_logo.png
$ ./auto_commit.sh

🔍 변경된 파일들을 분석중...
📁 변경된 파일들:
assets/images/new_logo.png

🤖 자동 생성된 커밋 메시지:
feat(assets): 리소스 파일 추가/수정

💡 사용법:
git commit -m "$(./auto_commit.sh)"

또는 직접 복사해서 사용하세요!
```

## ⚙️ 고급 설정

### Git Alias 설정
Git 명령어를 단축하여 더 편리하게 사용할 수 있습니다:

```bash
# ~/.gitconfig 파일에 추가
[alias]
    ac = "!f() { git add . && git commit -m \"$(./auto_commit.sh)\"; }; f"
    acp = "!f() { git add . && git commit -m \"$(./auto_commit.sh)\" && git push; }; f"
```

사용법:
```bash
# 변경사항 추가 + 자동 커밋
git ac

# 변경사항 추가 + 자동 커밋 + 푸시
git acp
```

### VS Code Tasks 설정
VS Code에서 Tasks를 통해 자동 커밋을 실행할 수 있습니다:

`.vscode/tasks.json` 파일 생성:
```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Auto Commit",
            "type": "shell",
            "command": "git commit -m \"$(./auto_commit.sh)\"",
            "group": {
                "kind": "build",
                "isDefault": true
            },
            "presentation": {
                "echo": true,
                "reveal": "always",
                "focus": false,
                "panel": "shared"
            },
            "problemMatcher": []
        }
    ]
}
```

## 🐛 문제 해결

### 권한 오류
```bash
# 권한 부족 시
chmod +x auto_commit.sh

# 권한 확인
ls -la auto_commit.sh
```

### 스크립트가 실행되지 않을 때
```bash
# 스크립트 경로 확인
pwd
ls -la auto_commit.sh

# 직접 실행
bash auto_commit.sh
```

### 빈 커밋 메시지가 생성될 때
- 스테이징된 파일이 있는지 확인: `git status`
- 파일이 올바르게 스테이징되었는지 확인: `git diff --cached`

## 🔧 커스터마이징

### 새로운 파일 패턴 추가
`auto_commit.sh` 파일을 편집하여 새로운 파일 패턴을 추가할 수 있습니다:

```bash
# 예: 테스트 파일 패턴 추가
TEST_FILES=$(echo "$CHANGED_FILES" | grep -E "test/|_test\.dart" || true)

# 커밋 메시지 생성 로직에 추가
elif [[ -n "$TEST_FILES" ]]; then
    echo "test: 테스트 코드 추가/수정"
```

### 커밋 메시지 형식 변경
스크립트 내의 `echo` 문을 수정하여 커밋 메시지 형식을 변경할 수 있습니다:

```bash
# 기존
echo "feat(auth): auth 기능 구현"

# 변경 예시
echo "✨ feat(auth): auth 기능 구현"
echo "feat: auth 기능 구현 (#123)"
```

## 📝 주의사항

1. **스테이징 필수**: 커밋하려는 파일들을 먼저 `git add`로 스테이징해야 합니다
2. **파일 경로 기반**: 파일의 경로와 확장자를 기반으로 분석하므로 정확한 경로 구조를 유지해야 합니다
3. **Conventional Commits**: 생성되는 메시지는 Conventional Commits 형식을 따릅니다
4. **백업 권장**: 중요한 프로젝트에서는 스크립트 실행 전 백업을 권장합니다

## 🤝 기여하기

이 스크립트를 개선하고 싶으시다면:
1. 새로운 파일 패턴 추가
2. 더 정교한 분석 로직 구현
3. 다국어 지원 추가
4. AI 기반 메시지 생성 연동

## 📄 라이선스

이 스크립트는 CLOZii 프로젝트용으로 제작되었으며, 자유롭게 사용하고 수정할 수 있습니다.

---

**💡 Tip**: 처음에는 스크립트를 실행해서 생성된 메시지를 확인한 후, 필요에 따라 수정하여 커밋하는 것을 권장합니다!
