#!/bin/bash

# CLOZii 프로젝트용 자동 커밋 메시지 생성 스크립트

echo "🔍 변경된 파일들을 분석중..."

# 변경된 파일들 가져오기
CHANGED_FILES=$(git diff --cached --name-only)
NEW_FILES=$(git diff --cached --name-only --diff-filter=A)
MODIFIED_FILES=$(git diff --cached --name-only --diff-filter=M)

# 파일 타입별 분석
DART_FILES=$(echo "$CHANGED_FILES" | grep -E "\.dart$" || true)
ANDROID_FILES=$(echo "$CHANGED_FILES" | grep -E "android/|\.gradle|\.kts" || true)
IOS_FILES=$(echo "$CHANGED_FILES" | grep -E "ios/|\.pbxproj|\.plist" || true)
CONFIG_FILES=$(echo "$CHANGED_FILES" | grep -E "pubspec\.yaml|pubspec\.lock|firebase\.json" || true)
ASSET_FILES=$(echo "$CHANGED_FILES" | grep -E "assets/|\.png|\.jpg|\.svg" || true)

echo "📁 변경된 파일들:"
echo "$CHANGED_FILES"

echo ""
echo "🤖 자동 생성된 커밋 메시지:"

# 커밋 메시지 생성 로직
if [[ -n "$DART_FILES" ]]; then
    # Dart 파일이 있는 경우
    if echo "$DART_FILES" | grep -q "features/"; then
        FEATURE=$(echo "$DART_FILES" | grep "features/" | head -1 | cut -d'/' -f2)
        echo "feat($FEATURE): $FEATURE 기능 구현"
    elif echo "$DART_FILES" | grep -q "core/"; then
        echo "feat(core): 핵심 기능 구현"
    elif echo "$DART_FILES" | grep -q "main.dart"; then
        echo "feat: 메인 앱 설정 변경"
    else
        echo "feat: Dart 코드 변경"
    fi
elif [[ -n "$ANDROID_FILES" ]]; then
    echo "feat(android): Android 플랫폼 설정"
elif [[ -n "$IOS_FILES" ]]; then
    echo "feat(ios): iOS 플랫폼 설정"
elif [[ -n "$CONFIG_FILES" ]]; then
    echo "chore: 프로젝트 설정 및 의존성 업데이트"
elif [[ -n "$ASSET_FILES" ]]; then
    echo "feat(assets): 리소스 파일 추가/수정"
else
    echo "chore: 기타 파일 변경"
fi

echo ""
echo "💡 사용법:"
echo "git commit -m \"\$(./auto_commit.sh)\""
echo ""
echo "또는 직접 복사해서 사용하세요!"
